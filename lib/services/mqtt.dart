import 'dart:async';
import 'dart:math';
import 'package:convert/convert.dart';
import 'package:cryptography_plus/cryptography_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:mqtt5_client/mqtt5_client.dart';
import 'package:mqtt5_client/mqtt5_server_client.dart';
import 'package:typed_data/typed_buffers.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:subspace_relay_pb/subspace_relay_pb.dart' as $pb;

import 'package:subspace_relay_mobile/services/prefs.dart';
import 'package:subspace_relay_mobile/services/relay_id.dart';

part 'mqtt.g.dart';
part 'mqtt.freezed.dart';

@riverpod
class BrokerUrl extends _$BrokerUrl {
  static final _defaultBrokerUrl = Uri.parse('mqtts://user:pass@example.com:8883');

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
      prefs.remove(kPrefsBroker);
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
  const factory RelayMessage({required $pb.Message message, required RpcResponseMetadata? rpcResponseMetadata}) = _RelayMessage;
}

@freezed
sealed class RpcResponseMetadata with _$RpcResponseMetadata {
  const factory RpcResponseMetadata({required String? responseTopic, required Uint8Buffer? correlationData}) = _RpcResponseMetadata;
}

@riverpod
class Mqtt extends _$Mqtt {
  static final _random = Random.secure();
  static const _contentTypeProto = 'application/proto';
  static const _topicBroadcastToRelay = 'subspace/broadcast/to-relay';
  static const _topicBroadcastFromRelay = 'subspace/broadcast/from-relay';
  final _pendingRpc = <String, Completer<$pb.Message>>{};
  late StreamController<RelayMessage> _stream;
  late RelayId _relayId;
  late CipherWand _crypto;
  late String _publishTopic;
  late String _subscribeTopic;
  late String _publishBroadcastTopic;
  late String _subscribeBroadcastTopic;
  late MqttServerClient _client;

  @override
  Future<Stream<RelayMessage>> build() async {
    _pendingRpc.forEach((_, completer) {
      completer.completeError(Exception('connection lost'));
    });
    _pendingRpc.clear();

    _stream = StreamController<RelayMessage>();
    ref.onDispose(_stream.close);

    _relayId = await ref.watch(relayIdProvider.future);

    _publishTopic = 'subspace/endpoint/${_relayId.mqttClientId}/from-relay';
    _subscribeTopic = 'subspace/endpoint/${_relayId.mqttClientId}/to-relay';
    _publishBroadcastTopic = _topicBroadcastFromRelay;
    _subscribeBroadcastTopic = _topicBroadcastToRelay;

    _crypto = await AesGcm.with128bits().newCipherWandFromSecretKey(_relayId.cryptoKey);

    final brokerUrl = await ref.watch(brokerUrlProvider.future);

    _client = MqttServerClient(brokerUrl.host, _relayId.mqttClientId, maxConnectionAttempts: 99999999);
    if (brokerUrl.hasPort) {
      _client.port = brokerUrl.port;
    }

    if (brokerUrl.queryParameters['trust_server_cert'] == 'true') {
      _client.onBadCertificate = (_) {
        return true;
      };
    }

    _client.secure = brokerUrl.scheme == "mqtts";
    _client.keepAlivePeriod = 15;
    _client.autoReconnect = true;
    _client.resubscribeOnAutoReconnect = true;
    if (kDebugMode) {
      _client.onAutoReconnect = () {
        print('onAutoReconnect');
      };
      _client.onAutoReconnected = () {
        print('onAutoReconnected');
      };
      _client.onConnected = () {
        print('onConnected');
      };
      _client.onDisconnected = () {
        print('onDisconnected');
      };
      _client.onFailedConnectionAttempt = (int attemptNumber) {
        print('onFailedConnectionAttempt($attemptNumber)');
      };
    }

    var connectionMessage = MqttConnectMessage().withClientIdentifier(_relayId.mqttClientId).keepAliveFor(MqttConstants.defaultKeepAlive).startClean();

    if (brokerUrl.userInfo.isNotEmpty) {
      final parts = brokerUrl.userInfo.split(':');
      final username = parts[0];
      final password = parts.length == 1 ? null : parts.sublist(1).join(':');
      connectionMessage = connectionMessage.authenticateAs(username, password);
    }

    _client.connectionMessage = connectionMessage;

    ref.onDispose(_client.disconnect);

    await _client.connect();

    _client.subscribe(_subscribeTopic, MqttQos.exactlyOnce);
    _client.subscribe(_subscribeBroadcastTopic, MqttQos.exactlyOnce);

    final subscription = _client.updates.listen(_onData);
    ref.onDispose(subscription.cancel);

    if (kDebugMode) {
      print('relay_id: ${_relayId.relayId}');
    }

    return _stream.stream;
  }

  Future<void> log(String message) async {
    await sendUnsolicited($pb.Message(log: $pb.Log(message: message)));
  }

  Future<void> sendUnsolicited($pb.Message msg, {bool broadcast = false}) async {
    await _send(msg, broadcast: broadcast);
  }

  Future<void> sendReply($pb.Message msg, RpcResponseMetadata? rpcResponseMetadata, {bool broadcast = false}) async {
    await _send(msg, topic: rpcResponseMetadata?.responseTopic, correlationData: rpcResponseMetadata?.correlationData, broadcast: broadcast);
  }

  Future<$pb.Message> rpc($pb.Message msg, {bool broadcast = false}) async {
    final correlationData = Uint8Buffer();
    correlationData.addAll(List<int>.generate(16, (i) => _random.nextInt(256)));

    final completer = Completer<$pb.Message>();
    _pendingRpc[hex.encode(correlationData)] = completer;

    await _send(msg, correlationData: correlationData, rpcRequest: true, broadcast: broadcast);

    return completer.future;
  }

  Future<void> _send($pb.Message msg, {String? topic, Uint8Buffer? correlationData, bool rpcRequest = false, bool broadcast = false}) async {
    final pbMessage = msg.writeToBuffer();

    Uint8Buffer messageBuffer = Uint8Buffer();
    if (broadcast) {
      messageBuffer.addAll(pbMessage);
    } else {
      final encryptedPayload = await _crypto.encrypt(pbMessage);
      messageBuffer.addAll(encryptedPayload.concatenation());
    }

    var publishMsg = MqttPublishMessage()
        .toTopic(topic ?? (broadcast ? _publishBroadcastTopic : _publishTopic))
        .withQos(MqttQos.exactlyOnce)
        .withContentType(_contentTypeProto)
        .publishData(messageBuffer);
    if (correlationData != null) {
      publishMsg = publishMsg.withResponseCorrelationdata(correlationData);
    }
    if (rpcRequest) {
      publishMsg = publishMsg.withResponseTopic(broadcast ? _subscribeBroadcastTopic : _subscribeTopic);
    }

    if (!ref.mounted) {
      throw 'attempt to publish when disposed';
    }

    if (_client.published == null) {
      throw 'publishing manager is null!';
    }

    _client.publishUserMessage(publishMsg);
  }

  void _onData(List<MqttReceivedMessage<MqttMessage>> c) async {
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

    List<int> decryptedPayload;
    final isBroadcast = c[0].topic == _subscribeBroadcastTopic;
    if (isBroadcast) {
      decryptedPayload = encryptedPayload;
    } else {
      decryptedPayload = await _crypto.decrypt(
        SecretBox.fromConcatenation(encryptedPayload, nonceLength: AesGcm.defaultNonceLength, macLength: AesGcm.aesGcmMac.macLength),
      );
    }

    final pbMessage = $pb.Message.fromBuffer(decryptedPayload);

    if (kDebugMode) {
      print(pbMessage);
    }

    if (isBroadcast && (!pbMessage.hasRequestRelayDiscovery() && !pbMessage.hasRelayDiscoveryEncrypted() && !pbMessage.hasRelayDiscoveryPlaintext())) {
      if (kDebugMode) {
        print('Ignoring unexpected broadcast message type');
      }
      return;
    }

    final correlationData = msg.variableHeader?.correlationData;
    if (correlationData != null && (msg.variableHeader?.responseTopic?.isEmpty ?? true)) {
      // RPC Reply
      final completer = _pendingRpc.remove(hex.encode(correlationData));
      if (completer != null) {
        completer.complete(pbMessage);
        return;
      }
    }

    RpcResponseMetadata? rpcResponseMetadata;
    if (msg.variableHeader?.responseTopic != null || correlationData != null) {
      String? responseTopic;
      if ((msg.variableHeader?.responseTopic ?? '') != '') {
        responseTopic = msg.variableHeader?.responseTopic;
      }
      rpcResponseMetadata = RpcResponseMetadata(responseTopic: responseTopic, correlationData: correlationData);
    }
    _stream.add(RelayMessage(message: pbMessage, rpcResponseMetadata: rpcResponseMetadata));
  }
}
