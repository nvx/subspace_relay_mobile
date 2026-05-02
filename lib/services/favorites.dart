import 'dart:convert';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:subspace_relay_mobile/services/prefs.dart';

part 'favorites.g.dart';
part 'favorites.freezed.dart';

const kPrefsFavorites = 'favorites';

@freezed
sealed class Favorite with _$Favorite {
  const factory Favorite({
    required String id,
    required String name,
    required String brokerUrl,
    @Default('') String discoveryPublicKey,
  }) = _Favorite;

  factory Favorite.fromJson(Map<String, dynamic> json) => _$FavoriteFromJson(json);
}

@riverpod
class FavoritesList extends _$FavoritesList {
  @override
  Future<List<Favorite>> build() async {
    final prefs = ref.watch(prefsProvider);
    final raw = await prefs.getString(kPrefsFavorites);
    if (raw == null) return [];

    try {
      final list = jsonDecode(raw) as List;
      return list.map((e) => Favorite.fromJson(e as Map<String, dynamic>)).toList();
    } catch (_) {
      return [];
    }
  }

  Future<void> _save(SharedPreferencesAsync prefs, List<Favorite> entries) async {
    await prefs.setString(kPrefsFavorites, jsonEncode(entries.map((e) => e.toJson()).toList()));
    if (ref.mounted) {
      state = AsyncValue.data(entries);
    }
  }

  Future<void> add({
    required String name,
    required String brokerUrl,
    required String discoveryPublicKey,
  }) async {
    final prefs = ref.read(prefsProvider);
    final current = await future;
    final entries = List<Favorite>.from(current);
    final id = DateTime.now().millisecondsSinceEpoch.toRadixString(36);
    entries.insert(0, Favorite(id: id, name: name, brokerUrl: brokerUrl, discoveryPublicKey: discoveryPublicKey));
    await _save(prefs, entries);
  }

  Future<void> updateFavorite(Favorite updated) async {
    final prefs = ref.read(prefsProvider);
    final current = await future;
    final entries = List<Favorite>.from(current);
    final idx = entries.indexWhere((e) => e.id == updated.id);
    if (idx < 0) return;
    entries[idx] = updated;
    await _save(prefs, entries);
  }

  Future<void> remove(String id) async {
    final prefs = ref.read(prefsProvider);
    final current = await future;
    final entries = List<Favorite>.from(current);
    entries.removeWhere((e) => e.id == id);
    await _save(prefs, entries);
  }
}
