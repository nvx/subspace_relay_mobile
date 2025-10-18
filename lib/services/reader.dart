import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:convert/convert.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:nfc_manager/nfc_manager.dart';
import 'package:nfc_manager/nfc_manager_android.dart';

import 'package:subspace_relay_pb/subspace_relay_pb.dart' as $pb;

import 'package:subspace_relay_mobile/services/discovery.dart';
import 'package:subspace_relay_mobile/services/log.dart';
import 'package:subspace_relay_mobile/services/mqtt.dart';
import 'package:subspace_relay_mobile/services/relay_id.dart';
import 'package:subspace_relay_mobile/services/version.dart';

part 'reader.g.dart';
part 'reader.freezed.dart';

@riverpod
class Reader extends _$Reader {
  @override
  Future<IsoDepAndroid?> build() async {
    NfcAvailability availability = await NfcManager.instance.checkAvailability();
    switch (availability) {
      case NfcAvailability.unsupported:
        throw 'NFC not supported';
      case NfcAvailability.disabled:
        throw 'NFC disabled';
      case NfcAvailability.enabled:
      // yay
    }

    NfcManager.instance.startSession(
      pollingOptions: {NfcPollingOption.iso14443},
      onDiscovered: (NfcTag tag) async {
        final isoTag = IsoDepAndroid.from(tag);
        state = AsyncValue.data(isoTag);
      },
    );

    ref.onDispose(() async {
      await NfcManager.instance.stopSession();
    });

    return null;
  }

  void disconnect() {
    state = AsyncValue.data(null);
  }
}

@freezed
sealed class ReaderRelayState with _$ReaderRelayState {
  const factory ReaderRelayState({required RelayId relayId, required IsoDepAndroid tag}) = _ReaderRelayState;
}

@riverpod
class ReaderRelay extends _$ReaderRelay {
  var _initial = true;

  @override
  Future<ReaderRelayState?> build(bool dynamicRelayId) async {
    final reader = await ref.watch(readerProvider.future);
    if (!ref.mounted || reader == null) {
      return null;
    }

    var relayId = await ref.read(relayIdProvider.future);
    if (dynamicRelayId) {
      relayId = await RelayId.fromString('${relayId.relayId}-${hex.encode(reader.tag.id)}');
    }

    final relayInfo = $pb.RelayInfo(
      connectionType: $pb.ConnectionType.CONNECTION_TYPE_NFC,
      supportedPayloadTypes: [$pb.PayloadType.PAYLOAD_TYPE_PCSC_READER],
      userAgent: '$appName/${await ref.watch(appVersionProvider.future)}',
    );

    final relayDiscovery = $pb.RelayDiscovery(relayId: relayId.relayId, relayInfo: relayInfo);
    final discoveryPubKey = await ref.read(discoveryPublicKeyProvider.future);

    if (!ref.mounted) {
      return null;
    }

    final mqttStream = await ref.watch(mqttProvider(relayId).future);
    if (!ref.mounted) {
      return null;
    }

    final mqttStreamSubscription = mqttStream.listen((msg) async {
      if (!ref.mounted) {
        if (kDebugMode) {
          print('got mqtt stream while not mounted');
        }
        return;
      }

      switch (msg.message.whichMessage()) {
        case $pb.Message_Message.requestRelayDiscovery:
          final req = msg.message.requestRelayDiscovery;
          if (req.controllerPublicKey.length != 32 ||
              (req.payloadType != $pb.PayloadType.PAYLOAD_TYPE_UNSPECIFIED && !relayInfo.supportedPayloadTypes.contains(req.payloadType)) ||
              !listEquals(discoveryPubKey, req.controllerPublicKey)) {
            break;
          }

          if (kDebugMode) {
            print('Sending RelayDiscovery reply');
          }

          final reply = await buildEncryptedRelayDiscovery(discoveryPubKey, relayDiscovery);
          await ref.read(mqttProvider(relayId).notifier).sendReply(reply, msg.rpcResponseMetadata, broadcast: true);
        case $pb.Message_Message.requestRelayInfo:
          final reply = $pb.Message(relayInfo: relayInfo);
          if (kDebugMode) {
            print('Sending RelayInfo reply');
          }
          await ref.read(mqttProvider(relayId).notifier).sendReply(reply, msg.rpcResponseMetadata);
        case $pb.Message_Message.log:
          if (kDebugMode) {
            print('Log from controlller: ${msg.message.log.message}');
          }
          ref.read(remoteLogProvider.notifier).log(msg.message.log.message);
        case $pb.Message_Message.reconnect:
          if (kDebugMode) {
            print('Reconnect');
          }
        case $pb.Message_Message.disconnect:
          if (kDebugMode) {
            print('Disconnect');
          }
          ref.read(readerProvider.notifier).disconnect();
        case $pb.Message_Message.payload:
          if (kDebugMode) {
            print('Payload: ${hex.encode(msg.message.payload.payload)}');
          }
          if (msg.message.payload.payloadType != $pb.PayloadType.PAYLOAD_TYPE_PCSC_READER) {
            if (kDebugMode) {
              print('Unsupported payload type: ${msg.message.payload.payloadType}');
            }
            return;
          }

          Uint8List rapdu;
          try {
            rapdu = await reader.transceive(Uint8List.fromList(msg.message.payload.payload));
          } catch (error, stackTrace) {
            if (kDebugMode) {
              print('Exception during transceive, card removed? $error\n$stackTrace');
            }
            ref.invalidate(readerProvider);
            return;
          }
          final payload = $pb.Payload(payload: rapdu, payloadType: $pb.PayloadType.PAYLOAD_TYPE_PCSC_READER);
          await ref.read(mqttProvider(relayId).notifier).sendReply($pb.Message(payload: payload), msg.rpcResponseMetadata);
        default:
          if (kDebugMode) {
            print('Unexpected payload type');
          }
      }
    });
    ref.onDispose(mqttStreamSubscription.cancel);

    if (discoveryPubKey.isNotEmpty && (_initial || dynamicRelayId)) {
      final reply = await buildEncryptedRelayDiscovery(discoveryPubKey, relayDiscovery);
      await ref.read(mqttProvider(relayId).notifier).sendReply(reply, null, broadcast: true);
    }

    _initial = false;

    return ReaderRelayState(relayId: relayId, tag: reader);
  }
}
