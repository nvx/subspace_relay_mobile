import 'dart:async';
import 'package:convert/convert.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:subspace_relay_mobile/services/mqtt.dart';

import 'package:subspacerelay/subspacerelay.dart' as $pb;

part 'hce.g.dart';

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
          print('< Field Off');
        } else {
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

  Future<bool> registerAidsForService(Uint8List aids) async {
    return await platform.invokeMethod<bool>('registerAidsForService', <String, dynamic>{'aids': aids}) ?? false;
  }
}

@riverpod
Future<void> hceRelay(Ref ref) async {
  final mqtt = await ref.watch(mqttProvider.future);
  if (!ref.mounted) {
    return;
  }

  final hceStream = await ref.watch(hceProvider.future);
  if (!ref.mounted) {
    return;
  }

  final hceStreamSubscription = hceStream.listen((capdu) {
    ref.read(mqttProvider.notifier).send($pb.Message(payload: $pb.Payload(payload: capdu, payloadType: $pb.PayloadType.PAYLOAD_TYPE_PCSC_CARD)));
  });
  ref.onDispose(hceStreamSubscription.cancel);
}
