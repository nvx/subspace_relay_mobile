import 'dart:async';
import 'package:async/async.dart';
import 'package:convert/convert.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:subspace_relay_pb/subspace_relay_pb.dart' as $pb;

import 'package:subspace_relay_mobile/services/apdu.dart';
import 'package:subspace_relay_mobile/services/mqtt.dart';
import 'package:subspace_relay_mobile/services/shortcut.dart';

part 'hce.g.dart';

@riverpod
class HceActive extends _$HceActive {
  @override
  bool build() {
    ref.keepAlive();
    return false;
  }

  void setActive(bool isInField) {
    state = isInField;
  }
}

@riverpod
class Hce extends _$Hce {
  static const platform = MethodChannel('io.nv.subspacerelay.mobile/hce');
  static const eventSource = EventChannel('io.nv.subspacerelay.mobile/hce/capdu');

  @override
  Future<Stream<Uint8List?>> build() async {
    ref.onDispose(removeAidsForService);

    final stream = StreamController<Uint8List?>();
    ref.onDispose(stream.close);

    final subscription = eventSource.receiveBroadcastStream().listen((msg) {
      if (kDebugMode) {
        if (msg == null) {
          ref.read(hceActiveProvider.notifier).setActive(false);
          print('< Field Off');
        } else {
          ref.read(hceActiveProvider.notifier).setActive(true);
          print('< ${hex.encode(msg).toUpperCase()}');
        }
      }

      stream.add(msg);
    });
    ref.onDispose(subscription.cancel);

    return stream.stream;
  }

  Future<void> sendResponseApdu(Uint8List rapdu) async {
    if (kDebugMode) {
      print('> ${hex.encode(rapdu).toUpperCase()}');
    }
    await platform.invokeMethod('sendResponseApdu', <String, dynamic>{'responseApdu': rapdu});
  }

  Future<bool> removeAidsForService() async {
    return await platform.invokeMethod<bool>('removeAidsForService') ?? false;
  }

  Future<bool> registerAidsForService(List<String> aids) async {
    return await platform.invokeMethod<bool>('registerAidsForService', <String, dynamic>{'aids': aids}) ?? false;
  }

  Future<bool> supportsAidPrefixRegistration() async {
    return await platform.invokeMethod<bool>('supportsAidPrefixRegistration') ?? false;
  }
}

enum HceState { invalid, idle, connected }

@riverpod
class HceRelay extends _$HceRelay {
  @override
  Future<HceState> build() async {
    int sequence = 0;

    final mqttStream = await ref.watch(mqttProvider.future);
    if (!ref.mounted) {
      return HceState.invalid;
    }

    final hceStream = await ref.watch(hceProvider.future);
    if (!ref.mounted) {
      return HceState.invalid;
    }

    final ephemeralShortcuts = <Shortcut>[];
    final persistentShortcuts = <Shortcut>[];
    final lastShortcutStack = <Shortcut>[];
    final mqttStreamSubscription = mqttStream.listen((msg) async {
      if (!ref.mounted) {
        if (kDebugMode) {
          print('got mqtt stream while not mounted');
        }
        return;
      }

      switch (msg.message.whichMessage()) {
        case $pb.Message_Message.requestRelayInfo:
          final reply = $pb.Message(
            relayInfo: $pb.RelayInfo(
              connectionType: $pb.ConnectionType.CONNECTION_TYPE_NFC,
              supportedPayloadTypes: [$pb.PayloadType.PAYLOAD_TYPE_PCSC_CARD],
              supportsShortcut: true,
              requiresAidList: true,
            ),
          );
          if (kDebugMode) {
            print('Sending RelayInfo reply');
          }
          await ref.read(mqttProvider.notifier).sendReply(reply, msg.rpcResponseMetadata);
        case $pb.Message_Message.log:
          if (kDebugMode) {
            print('Log from controlller: ${msg.message.log.message}');
          }
        case $pb.Message_Message.reconnect:
          if (kDebugMode) {
            print('Reconnect');
          }

          state = AsyncValue.data(HceState.connected);

          if (msg.message.reconnect.forceFlushShortcuts) {
            ephemeralShortcuts.clear();
            persistentShortcuts.clear();
          } else {
            ephemeralShortcuts.removeWhere((e) => !e.persistReconnect);
            persistentShortcuts.removeWhere((e) => !e.persistReconnect);
          }

          for (final pbShortcut in msg.message.reconnect.shortcuts) {
            final shortcut = Shortcut.fromPb(pbShortcut, msg.rpcResponseMetadata);
            if (pbShortcut.persistent) {
              persistentShortcuts.add(shortcut);
            } else {
              ephemeralShortcuts.add(shortcut);
            }
          }
          sortShortcuts(persistentShortcuts);
          sortShortcuts(ephemeralShortcuts);

          if (await ref.read(hceProvider.notifier).supportsAidPrefixRegistration()) {
            if (kDebugMode) {
              print('Supports wildcard!');
            }
          } else {
            if (kDebugMode) {
              print('No wildcard');
            }
          }
          final aids = msg.message.reconnect.aidList.map((aid) => hex.encode(aid).toUpperCase()).toList();
          // TODO: If wildcard AID supported add wildcard?
          if (aids.isNotEmpty) {
            await ref.read(hceProvider.notifier).registerAidsForService(aids);
          }
        case $pb.Message_Message.disconnect:
          if (kDebugMode) {
            print('Disconnect');
          }

          state = AsyncValue.data(HceState.idle);

          await ref.read(hceProvider.notifier).removeAidsForService();
          ephemeralShortcuts.removeWhere((e) => !e.persistReconnect);
          persistentShortcuts.removeWhere((e) => !e.persistReconnect);
        case $pb.Message_Message.emulationShortcut:
          final shortcut = Shortcut.fromPb(msg.message.emulationShortcut, msg.rpcResponseMetadata);
          if (msg.message.emulationShortcut.persistent) {
            persistentShortcuts.add(shortcut);
            sortShortcuts(persistentShortcuts);
          } else {
            ephemeralShortcuts.add(shortcut);
            sortShortcuts(ephemeralShortcuts);
          }
        default:
          throw 'Unexpected payload type';
      }
    });
    ref.onDispose(mqttStreamSubscription.cancel);

    Function()? cancelPendingHce;
    final hceStreamSubscription = hceStream.listen((capdu) async {
      cancelPendingHce?.call();
      if (capdu == null) {
        if (kDebugMode) {
          print('Field off');
        }
        return;
      }

      if (!ref.mounted) {
        if (kDebugMode) {
          print('got hce while not mounted');
        }
        return;
      }

      Future<void> handleShortcut(Shortcut shortcut, Uint8List capdu) async {
        if (kDebugMode) {
          print('Shortcut');
        }
        shortcut.usedEphemeral.clear();
        lastShortcutStack.add(shortcut);

        if (shortcut.sendCapdu) {
          final payload = $pb.Payload(payload: capdu, payloadType: $pb.PayloadType.PAYLOAD_TYPE_PCSC_CARD, sequence: sequence);
          sequence++;

          // deliberately not awaited
          ref.read(mqttProvider.notifier).sendReply($pb.Message(payload: payload), shortcut.rpcResponseMetadata);
        }

        await ref.read(hceProvider.notifier).sendResponseApdu(shortcut.rapdu);
      }

      if (ephemeralShortcuts.isNotEmpty || persistentShortcuts.isNotEmpty || lastShortcutStack.isNotEmpty) {
        try {
          final parsedCapdu = Capdu.fromBytes(capdu);
          while (lastShortcutStack.isNotEmpty) {
            final lastShortcut = lastShortcutStack.last;

            for (final (i, shortcut) in lastShortcut.ephemeralChildren.indexed) {
              if (lastShortcut.usedEphemeral.contains(i)) {
                continue;
              }

              if (!shortcut.capduMatch(parsedCapdu)) {
                continue;
              }

              lastShortcut.usedEphemeral.add(i);

              await handleShortcut(shortcut, capdu);
              return;
            }

            for (final shortcut in lastShortcut.persistentChildren) {
              if (!shortcut.capduMatch(parsedCapdu)) {
                continue;
              }

              await handleShortcut(shortcut, capdu);
              return;
            }

            lastShortcutStack.removeAt(lastShortcutStack.length - 1);
          }

          for (final (i, shortcut) in ephemeralShortcuts.indexed) {
            if (!shortcut.capduMatch(parsedCapdu)) {
              continue;
            }

            ephemeralShortcuts.removeAt(i);

            await handleShortcut(shortcut, capdu);
            return;
          }

          for (final shortcut in persistentShortcuts) {
            if (!shortcut.capduMatch(parsedCapdu)) {
              continue;
            }

            await handleShortcut(shortcut, capdu);
            return;
          }

          // no shortcut match, fall through to non-shortcut handling
        } catch (error, stackTrace) {
          if (kDebugMode) {
            print('Caught exception parsing cAPDU for shortcut handling, skipping shortcut handling: $error\n$stackTrace');
          }
        }
      }

      if (kDebugMode) {
        print('Non-shortcut');
      }

      final payload = $pb.Payload(payload: capdu, payloadType: $pb.PayloadType.PAYLOAD_TYPE_PCSC_CARD, sequence: sequence);
      sequence++;

      final rpcFuture = CancelableOperation<$pb.Message>.fromFuture(ref.read(mqttProvider.notifier).rpc($pb.Message(payload: payload)));
      cancelPendingHce = rpcFuture.cancel;
      final res = await rpcFuture.valueOrCancellation(null);

      if (res == null) {
        if (kDebugMode) {
          print('Pending reply cancelled');
        }
        return;
      }

      cancelPendingHce = null;

      if (res.payload.payload.isEmpty || res.payload.payloadType != $pb.PayloadType.PAYLOAD_TYPE_PCSC_CARD) {
        throw 'Unexpected response to cAPDU';
      }

      ref.read(hceProvider.notifier).sendResponseApdu(Uint8List.fromList(res.payload.payload));
    });

    ref.onDispose(hceStreamSubscription.cancel);

    return HceState.idle;
  }
}
