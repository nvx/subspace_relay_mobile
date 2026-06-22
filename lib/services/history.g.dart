// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'history.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_HistoryEntry _$HistoryEntryFromJson(Map<String, dynamic> json) =>
    _HistoryEntry(
      id: json['id'] as String,
      name: json['name'] as String,
      brokerUrl: json['brokerUrl'] as String,
      discoveryPublicKey: json['discoveryPublicKey'] as String,
      relayId: json['relayId'] as String,
      mode: $enumDecode(_$ConnectionModeEnumMap, json['mode']),
      timestamp: DateTime.parse(json['timestamp'] as String),
      log: json['log'] as String? ?? '',
    );

Map<String, dynamic> _$HistoryEntryToJson(_HistoryEntry instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'brokerUrl': instance.brokerUrl,
      'discoveryPublicKey': instance.discoveryPublicKey,
      'relayId': instance.relayId,
      'mode': _$ConnectionModeEnumMap[instance.mode]!,
      'timestamp': instance.timestamp.toIso8601String(),
      'log': instance.log,
    };

const _$ConnectionModeEnumMap = {
  ConnectionMode.hce: 'hce',
  ConnectionMode.reader: 'reader',
  ConnectionMode.readerDynamic: 'readerDynamic',
};

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(ConnectionHistory)
final connectionHistoryProvider = ConnectionHistoryProvider._();

final class ConnectionHistoryProvider
    extends $AsyncNotifierProvider<ConnectionHistory, List<HistoryEntry>> {
  ConnectionHistoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'connectionHistoryProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$connectionHistoryHash();

  @$internal
  @override
  ConnectionHistory create() => ConnectionHistory();
}

String _$connectionHistoryHash() => r'87a3e5aaec0a64ac8246b6cbb25db25c036141dd';

abstract class _$ConnectionHistory extends $AsyncNotifier<List<HistoryEntry>> {
  FutureOr<List<HistoryEntry>> build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref =
        this.ref as $Ref<AsyncValue<List<HistoryEntry>>, List<HistoryEntry>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<List<HistoryEntry>>, List<HistoryEntry>>,
              AsyncValue<List<HistoryEntry>>,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}
