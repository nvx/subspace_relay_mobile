// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'reader.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(Reader)
final readerProvider = ReaderProvider._();

final class ReaderProvider extends $AsyncNotifierProvider<Reader, NfcTag?> {
  ReaderProvider._()
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

String _$readerHash() => r'dab37cec622d3923770325bc09113ac142b91f6b';

abstract class _$Reader extends $AsyncNotifier<NfcTag?> {
  FutureOr<NfcTag?> build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<AsyncValue<NfcTag?>, NfcTag?>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<NfcTag?>, NfcTag?>,
              AsyncValue<NfcTag?>,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}

@ProviderFor(ReaderRelay)
final readerRelayProvider = ReaderRelayFamily._();

final class ReaderRelayProvider
    extends $AsyncNotifierProvider<ReaderRelay, ReaderRelayState?> {
  ReaderRelayProvider._({
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

String _$readerRelayHash() => r'd268abe57b5baea3df349b75ac3bbc85a96311ea';

final class ReaderRelayFamily extends $Family
    with
        $ClassFamilyOverride<
          ReaderRelay,
          AsyncValue<ReaderRelayState?>,
          ReaderRelayState?,
          FutureOr<ReaderRelayState?>,
          bool
        > {
  ReaderRelayFamily._()
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
  WhenComplete runBuild() {
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
    return element.handleCreate(ref, () => build(_$args));
  }
}
