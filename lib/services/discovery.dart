import 'dart:convert';
import 'package:convert/convert.dart';
import 'package:cryptography_flutter_plus/cryptography_flutter_plus.dart';
import 'package:cryptography_plus/cryptography_plus.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:subspace_relay_pb/subspace_relay_pb.dart' as $pb;

import 'package:subspace_relay_mobile/services/prefs.dart';

part 'discovery.g.dart';

@riverpod
class DiscoveryPublicKey extends _$DiscoveryPublicKey {
  @override
  Future<List<int>> build() async {
    final prefs = ref.watch(prefsProvider);

    final hexValue = await prefs.getString(kPrefsDiscoveryPubKey);
    if (hexValue == null) {
      return [];
    }

    try {
      return hex.decode(hexValue);
    } catch (_) {
      prefs.remove(kPrefsDiscoveryPubKey);
      return [];
    }
  }

  Future<void> updatePublicKey(List<int> publicKey) async {
    state = AsyncValue.data(publicKey);
    await ref.read(prefsProvider).setString(kPrefsDiscoveryPubKey, hex.encode(publicKey));
  }
}

Future<$pb.Message> buildEncryptedRelayDiscovery(List<int> pubKey, $pb.RelayDiscovery relayDiscovery) async {
  final wand = await FlutterX25519(X25519()).newKeyExchangeWand();
  final rawSharedKey = await wand.sharedSecretKey(remotePublicKey: SimplePublicKey(pubKey, type: KeyPairType.x25519));

  const pbkdfIterations = 20;
  const pbkdfBits = 16 * 8;
  final pbkdf2 = FlutterPbkdf2(
    fallback: Pbkdf2(macAlgorithm: Hmac.sha256(), iterations: pbkdfIterations, bits: pbkdfBits),
    macAlgorithm: Hmac.sha256(),
    iterations: pbkdfIterations,
    bits: pbkdfBits,
  );

  final sharedKey = await pbkdf2.deriveKey(secretKey: rawSharedKey, nonce: utf8.encode('discovery'));

  final crypto = await FlutterAesGcm.with128bits().newCipherWandFromSecretKey(sharedKey);

  final encryptedRelayDiscovery = await crypto.encrypt(relayDiscovery.writeToBuffer());

  return $pb.Message(
    relayDiscoveryEncrypted: $pb.RelayDiscoveryEncrypted(
      controllerPublicKey: pubKey,
      relayPublicKey: (await wand.extractPublicKey() as SimplePublicKey).bytes,
      encryptedRelayDiscovery: encryptedRelayDiscovery.concatenation(),
    ),
  );
}
