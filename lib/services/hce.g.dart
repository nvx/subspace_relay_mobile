// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hce.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(HceActive)
const hceActiveProvider = HceActiveProvider._();

final class HceActiveProvider extends $NotifierProvider<HceActive, bool> {
  const HceActiveProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'hceActiveProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$hceActiveHash();

  @$internal
  @override
  HceActive create() => HceActive();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(bool value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<bool>(value),
    );
  }
}

String _$hceActiveHash() => r'584d1b5ed0b488b6762926315a359733002e632b';

abstract class _$HceActive extends $Notifier<bool> {
  bool build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<bool, bool>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<bool, bool>,
              bool,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}

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

String _$hceHash() => r'c5bec65cff37e458d675e1f61959fd85d83b9bda';

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

@ProviderFor(HceRelay)
const hceRelayProvider = HceRelayProvider._();

final class HceRelayProvider
    extends $AsyncNotifierProvider<HceRelay, HceRelayState> {
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
  HceRelay create() => HceRelay();
}

String _$hceRelayHash() => r'1d386fe0605ce86f429f3a99a4aa7b816189707b';

abstract class _$HceRelay extends $AsyncNotifier<HceRelayState> {
  FutureOr<HceRelayState> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<AsyncValue<HceRelayState>, HceRelayState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<HceRelayState>, HceRelayState>,
              AsyncValue<HceRelayState>,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}
