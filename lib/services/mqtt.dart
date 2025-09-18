import 'dart:async';
import 'package:cryptography_plus/cryptography_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:mqtt5_client/mqtt5_client.dart';
import 'package:mqtt5_client/mqtt5_server_client.dart';
import 'package:typed_data/typed_buffers.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:subspacerelay/subspacerelay.dart' as $pb;

import 'package:subspace_relay_mobile/services/prefs.dart';
import 'package:subspace_relay_mobile/services/relay_id.dart';

part 'mqtt.g.dart';
part 'mqtt.freezed.dart';

@riverpod
class BrokerUri extends _$BrokerUri {
  static final _defaultBrokerUrl = Uri.parse(const String.fromEnvironment('BROKER_URL', defaultValue: 'mqtts://user:pass@example.com:1234'));

  @override
  Future<Uri> build() async {
    final prefs = ref.watch(prefsProvider);

    final prefsBroker = await prefs.getString(kPrefsBroker);
    if (prefsBroker == null) {
      return _defaultBrokerUrl;
    }

    try {
      return Uri.parse(prefsBroker);
    } on FormatException {
      return _defaultBrokerUrl;
    }
  }

  Future<void> resetBrokerUrl() async {
    await ref.read(prefsProvider).remove(kPrefsBroker);
    ref.invalidateSelf();
  }

  Future<void> updateBrokerUrl(String brokerUrl) async {
    state = AsyncValue.data(Uri.parse(brokerUrl));
    await ref.read(prefsProvider).setString(kPrefsBroker, brokerUrl);
  }
}

@freezed
sealed class RelayMessage with _$RelayMessage {
  factory RelayMessage({required $pb.Message message, required Uint8Buffer? correlationData}) = _RelayMessage;
}

@riverpod
class Mqtt extends _$Mqtt {
  static const _contentTypeProto = 'application/proto';
  late StreamController<RelayMessage> _stream;
  late RelayId _relayId;
  late CipherWand _crypto;
  late String _publishTopic;
  late String _subscribeTopic;
  late MqttServerClient _client;

  @override
  Future<Stream<RelayMessage>> build() async {
    _stream = StreamController<RelayMessage>();
    ref.onDispose(_stream.close);

    _relayId = await ref.watch(relayIdProvider.future);

    _publishTopic = 'subspace/endpoint/${_relayId.mqttClientId}/from-relay';
    _subscribeTopic = 'subspace/endpoint/${_relayId.mqttClientId}/to-relay';

    _crypto = await AesGcm.with128bits().newCipherWandFromSecretKey(_relayId.cryptoKey);

    final brokerUri = await ref.watch(brokerUriProvider.future);

    _client = MqttServerClient(brokerUri.host, _relayId.mqttClientId);
    if (brokerUri.hasPort) {
      _client.port = brokerUri.port;
    }

    _client.secure = brokerUri.scheme == "mqtts";
    _client.keepAlivePeriod = 15;
    _client.autoReconnect = true;
    _client.resubscribeOnAutoReconnect = true;

    var connectionMessage = MqttConnectMessage().withClientIdentifier(_relayId.mqttClientId).keepAliveFor(MqttConstants.defaultKeepAlive).startClean();

    if (brokerUri.userInfo.isNotEmpty) {
      final parts = brokerUri.userInfo.split(':');
      final username = parts[0];
      final password = parts.length == 1 ? null : parts.sublist(1).join(':');
      connectionMessage = connectionMessage.authenticateAs(username, password);
    }

    _client.connectionMessage = connectionMessage;

    ref.onDispose(_client.disconnect);

    await _client.connect();

    _client.subscribe(_subscribeTopic, MqttQos.exactlyOnce);

    final subscription = _client.updates.listen(onData);
    ref.onDispose(subscription.cancel);

    if (kDebugMode) {
      print('relay_id: ${_relayId.relayId}');
    }

    return _stream.stream;
  }

  Future<void> send($pb.Message msg, {Uint8Buffer? correlationData, bool responseTopic = false}) async {
    final pbMessage = msg.writeToBuffer();

    final encryptedPayload = await _crypto.encrypt(pbMessage);

    Uint8Buffer messageBuffer = Uint8Buffer();
    messageBuffer.addAll(encryptedPayload.concatenation());

    var publishMsg = MqttPublishMessage().toTopic(_publishTopic).withQos(MqttQos.exactlyOnce).withContentType(_contentTypeProto).publishData(messageBuffer);
    if (correlationData != null) {
      publishMsg = publishMsg.withResponseCorrelationdata(correlationData);
    }
    if (responseTopic) {
      publishMsg = publishMsg.withResponseTopic(_subscribeTopic);
    }

    _client.publishUserMessage(publishMsg);
  }

  void onData(List<MqttReceivedMessage<MqttMessage>> c) async {
    if (!ref.mounted) {
      return;
    }

    final msg = c[0].payload as MqttPublishMessage;
    if (msg.payload.variableHeader?.contentType != _contentTypeProto) {
      if (kDebugMode) {
        print('unexpected content type');
      }
      return;
    }

    final encryptedPayload = msg.payload.message;
    if (encryptedPayload == null) {
      return;
    }

    final decryptedPayload = await _crypto.decrypt(
      SecretBox.fromConcatenation(encryptedPayload, nonceLength: AesGcm.defaultNonceLength, macLength: AesGcm.aesGcmMac.macLength),
    );

    final pbMessage = $pb.Message.fromBuffer(decryptedPayload);

    if (kDebugMode) {
      print(pbMessage);
    }

    _stream.add(RelayMessage(message: pbMessage, correlationData: msg.variableHeader?.correlationData));
  }
}
