// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'log.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(RemoteLog)
final remoteLogProvider = RemoteLogProvider._();

final class RemoteLogProvider
    extends $NotifierProvider<RemoteLog, List<LogEntry>> {
  RemoteLogProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'remoteLogProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$remoteLogHash();

  @$internal
  @override
  RemoteLog create() => RemoteLog();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(List<LogEntry> value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<List<LogEntry>>(value),
    );
  }
}

String _$remoteLogHash() => r'c04d077a3941733446a3225e6790b57df12f7e62';

abstract class _$RemoteLog extends $Notifier<List<LogEntry>> {
  List<LogEntry> build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<List<LogEntry>, List<LogEntry>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<List<LogEntry>, List<LogEntry>>,
              List<LogEntry>,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}
