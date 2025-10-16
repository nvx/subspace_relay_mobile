// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'relay_id.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(relayId)
const relayIdProvider = RelayIdProvider._();

final class RelayIdProvider
    extends $FunctionalProvider<AsyncValue<RelayId>, RelayId, FutureOr<RelayId>>
    with $FutureModifier<RelayId>, $FutureProvider<RelayId> {
  const RelayIdProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'relayIdProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$relayIdHash();

  @$internal
  @override
  $FutureProviderElement<RelayId> $createElement($ProviderPointer pointer) =>
      $FutureProviderElement(pointer);

  @override
  FutureOr<RelayId> create(Ref ref) {
    return relayId(ref);
  }
}

String _$relayIdHash() => r'3a31083be3fc1654a978d4f76309d2fe57757654';
