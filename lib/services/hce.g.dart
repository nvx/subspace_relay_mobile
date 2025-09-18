// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hce.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(Hce)
const hceProvider = HceProvider._();

final class HceProvider
    extends $AsyncNotifierProvider<Hce, Stream<Uint8List?>> {
  const HceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'hceProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$hceHash();

  @$internal
  @override
  Hce create() => Hce();
}

String _$hceHash() => r'a3b1f1bc9f212c6f905e515a7bf2c620aea61838';

abstract class _$Hce extends $AsyncNotifier<Stream<Uint8List?>> {
  FutureOr<Stream<Uint8List?>> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref =
        this.ref as $Ref<AsyncValue<Stream<Uint8List?>>, Stream<Uint8List?>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<Stream<Uint8List?>>, Stream<Uint8List?>>,
              AsyncValue<Stream<Uint8List?>>,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}

@ProviderFor(hceRelay)
const hceRelayProvider = HceRelayProvider._();

final class HceRelayProvider
    extends $FunctionalProvider<AsyncValue<void>, void, FutureOr<void>>
    with $FutureModifier<void>, $FutureProvider<void> {
  const HceRelayProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'hceRelayProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$hceRelayHash();

  @$internal
  @override
  $FutureProviderElement<void> $createElement($ProviderPointer pointer) =>
      $FutureProviderElement(pointer);

  @override
  FutureOr<void> create(Ref ref) {
    return hceRelay(ref);
  }
}

String _$hceRelayHash() => r'3db3dbe3327ed477bbcef72b325bbabc4aa8524b';
