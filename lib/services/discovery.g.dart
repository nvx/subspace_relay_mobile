// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'discovery.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(DiscoveryPublicKey)
const discoveryPublicKeyProvider = DiscoveryPublicKeyProvider._();

final class DiscoveryPublicKeyProvider
    extends $AsyncNotifierProvider<DiscoveryPublicKey, List<int>> {
  const DiscoveryPublicKeyProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'discoveryPublicKeyProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$discoveryPublicKeyHash();

  @$internal
  @override
  DiscoveryPublicKey create() => DiscoveryPublicKey();
}

String _$discoveryPublicKeyHash() =>
    r'2a465b77216256457e55b4e5c16db6f9bc62c049';

abstract class _$DiscoveryPublicKey extends $AsyncNotifier<List<int>> {
  FutureOr<List<int>> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<AsyncValue<List<int>>, List<int>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<List<int>>, List<int>>,
              AsyncValue<List<int>>,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}
