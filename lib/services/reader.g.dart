// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'reader.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(Reader)
const readerProvider = ReaderProvider._();

final class ReaderProvider
    extends $AsyncNotifierProvider<Reader, IsoDepAndroid?> {
  const ReaderProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'readerProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$readerHash();

  @$internal
  @override
  Reader create() => Reader();
}

String _$readerHash() => r'86228f4f0e8aaef65606d9cfe18f91e21d68aa64';

abstract class _$Reader extends $AsyncNotifier<IsoDepAndroid?> {
  FutureOr<IsoDepAndroid?> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<AsyncValue<IsoDepAndroid?>, IsoDepAndroid?>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<IsoDepAndroid?>, IsoDepAndroid?>,
              AsyncValue<IsoDepAndroid?>,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}

@ProviderFor(ReaderRelay)
const readerRelayProvider = ReaderRelayFamily._();

final class ReaderRelayProvider
    extends $AsyncNotifierProvider<ReaderRelay, ReaderRelayState?> {
  const ReaderRelayProvider._({
    required ReaderRelayFamily super.from,
    required bool super.argument,
  }) : super(
         retry: null,
         name: r'readerRelayProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$readerRelayHash();

  @override
  String toString() {
    return r'readerRelayProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  ReaderRelay create() => ReaderRelay();

  @override
  bool operator ==(Object other) {
    return other is ReaderRelayProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$readerRelayHash() => r'd0e2891d9d65cf24240eef64bb68ea7dd90611f3';

final class ReaderRelayFamily extends $Family
    with
        $ClassFamilyOverride<
          ReaderRelay,
          AsyncValue<ReaderRelayState?>,
          ReaderRelayState?,
          FutureOr<ReaderRelayState?>,
          bool
        > {
  const ReaderRelayFamily._()
    : super(
        retry: null,
        name: r'readerRelayProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  ReaderRelayProvider call(bool dynamicRelayId) =>
      ReaderRelayProvider._(argument: dynamicRelayId, from: this);

  @override
  String toString() => r'readerRelayProvider';
}

abstract class _$ReaderRelay extends $AsyncNotifier<ReaderRelayState?> {
  late final _$args = ref.$arg as bool;
  bool get dynamicRelayId => _$args;

  FutureOr<ReaderRelayState?> build(bool dynamicRelayId);
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build(_$args);
    final ref =
        this.ref as $Ref<AsyncValue<ReaderRelayState?>, ReaderRelayState?>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<ReaderRelayState?>, ReaderRelayState?>,
              AsyncValue<ReaderRelayState?>,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}
