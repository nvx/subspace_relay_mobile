import 'dart:convert';
import 'package:convert/convert.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:uuid/uuid.dart';
import 'package:cryptography_flutter_plus/cryptography_flutter_plus.dart';
import 'package:cryptography_plus/cryptography_plus.dart';

import 'package:subspace_relay_mobile/services/prefs.dart';

part 'relay_id.g.dart';
part 'relay_id.freezed.dart';

@freezed
sealed class RelayId with _$RelayId {
  static const _pbkdfIterations = 20;
  static const _pbkdfBits = 16 * 8;
  const factory RelayId({required String relayId, required String mqttClientId, required SecretKey cryptoKey}) = _RelayId;

  static Future<RelayId> fromString(String relayId) async {
    final pbkdf2 = FlutterPbkdf2(
      fallback: Pbkdf2(macAlgorithm: Hmac.sha256(), iterations: _pbkdfIterations, bits: _pbkdfBits),
      macAlgorithm: Hmac.sha256(),
      iterations: _pbkdfIterations,
      bits: _pbkdfBits,
    );

    final mqttClientId = hex.encode(await (await pbkdf2.deriveKeyFromPassword(password: relayId, nonce: utf8.encode('mqtt-id'))).extractBytes());

    final cryptoKey = await pbkdf2.deriveKeyFromPassword(password: relayId, nonce: utf8.encode('aead-crypto-key'));

    return RelayId(relayId: relayId, mqttClientId: mqttClientId, cryptoKey: cryptoKey);
  }
}

@riverpod
Future<RelayId> relayId(Ref ref) async {
  final prefs = ref.watch(prefsProvider);

  String? relayId;
  if (!ref.isRefresh) {
    relayId = await prefs.getString(kPrefsRelayId);
  }

  if (relayId == null || relayId.isEmpty) {
    relayId = Uuid().v4().replaceAll('-', '');
    await prefs.setString(kPrefsRelayId, relayId);
  }

  return RelayId.fromString(relayId);
}
