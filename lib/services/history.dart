import 'dart:convert';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:subspace_relay_mobile/connection_mode.dart';
import 'package:subspace_relay_mobile/services/prefs.dart';

part 'history.g.dart';
part 'history.freezed.dart';

const kPrefsConnectionHistory = 'connection_history';

@freezed
sealed class HistoryEntry with _$HistoryEntry {
  const factory HistoryEntry({
    required String id,
    required String name,
    required String brokerUrl,
    required String discoveryPublicKey,
    required String relayId,
    required ConnectionMode mode,
    required DateTime timestamp,
    @Default('') String log,
  }) = _HistoryEntry;

  factory HistoryEntry.fromJson(Map<String, dynamic> json) => _$HistoryEntryFromJson(json);
}

@riverpod
class ConnectionHistory extends _$ConnectionHistory {
  @override
  Future<List<HistoryEntry>> build() async {
    final prefs = ref.watch(prefsProvider);
    final raw = await prefs.getString(kPrefsConnectionHistory);
    if (raw == null) return [];

    try {
      final list = jsonDecode(raw) as List;
      return list.map((e) => HistoryEntry.fromJson(e as Map<String, dynamic>)).toList();
    } catch (_) {
      return [];
    }
  }

  /// Persist entries to prefs and update state if still mounted.
  /// [prefs] must be captured before any async gaps to avoid using a disposed ref.
  Future<void> _persist(SharedPreferencesAsync prefs, List<HistoryEntry> entries) async {
    await prefs.setString(kPrefsConnectionHistory, jsonEncode(entries.map((e) => e.toJson()).toList()));
    if (ref.mounted) {
      state = AsyncValue.data(entries);
    }
  }

  /// Always creates a new history entry for each connection run.
  Future<String> add({
    required String brokerUrl,
    required String discoveryPublicKey,
    required String relayId,
    required ConnectionMode mode,
    String? name,
  }) async {
    // Capture prefs before any async gap so we can save even if provider is disposed mid-await.
    final prefs = ref.read(prefsProvider);
    final current = await future;
    final entries = List<HistoryEntry>.from(current);
    final now = DateTime.now();
    final id = now.millisecondsSinceEpoch.toRadixString(36);
    final displayName = name ?? Uri.tryParse(brokerUrl)?.host ?? brokerUrl;

    entries.insert(
      0,
      HistoryEntry(id: id, name: displayName, brokerUrl: brokerUrl, discoveryPublicKey: discoveryPublicKey, relayId: relayId, mode: mode, timestamp: now),
    );

    // Keep max 50 entries
    if (entries.length > 50) entries.removeRange(50, entries.length);

    await _persist(prefs, entries);
    return id;
  }

  Future<void> remove(String id) async {
    final prefs = ref.read(prefsProvider);
    final current = await future;
    final entries = List<HistoryEntry>.from(current);
    entries.removeWhere((e) => e.id == id);
    await _persist(prefs, entries);
  }

  Future<void> updateLog(String id, String log) async {
    final prefs = ref.read(prefsProvider);
    final current = await future;
    final entries = List<HistoryEntry>.from(current);
    final idx = entries.indexWhere((e) => e.id == id);
    if (idx < 0) return;
    entries[idx] = entries[idx].copyWith(log: log);
    await _persist(prefs, entries);
  }
}
