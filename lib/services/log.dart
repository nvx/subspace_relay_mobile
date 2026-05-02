import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'log.g.dart';
part 'log.freezed.dart';

@freezed
sealed class LogEntry with _$LogEntry {
  const factory LogEntry({required DateTime timestamp, required String message}) = _LogEntry;
}

@riverpod
class RemoteLog extends _$RemoteLog {
  @override
  List<LogEntry> build() {
    return [];
  }

  void log(String message) {
    var existing = state;
    if (existing.length >= 100) {
      existing = existing.sublist(0, existing.length - 1);
    }
    state = [LogEntry(timestamp: DateTime.now(), message: message), ...existing];
  }
}
