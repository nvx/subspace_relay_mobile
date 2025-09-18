// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'mqtt.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(BrokerUri)
const brokerUriProvider = BrokerUriProvider._();

final class BrokerUriProvider extends $AsyncNotifierProvider<BrokerUri, Uri> {
  const BrokerUriProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'brokerUriProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$brokerUriHash();

  @$internal
  @override
  BrokerUri create() => BrokerUri();
}

String _$brokerUriHash() => r'25dc70f8308c9ab1e2c3630a590e4443846c5356';

abstract class _$BrokerUri extends $AsyncNotifier<Uri> {
  FutureOr<Uri> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<AsyncValue<Uri>, Uri>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<Uri>, Uri>,
              AsyncValue<Uri>,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}

@ProviderFor(Mqtt)
const mqttProvider = MqttProvider._();

final class MqttProvider
    extends $AsyncNotifierProvider<Mqtt, Stream<RelayMessage>> {
  const MqttProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'mqttProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$mqttHash();

  @$internal
  @override
  Mqtt create() => Mqtt();
}

String _$mqttHash() => r'83219f30e52698a5ab7aadf6fb8dc52f02b0a645';

abstract class _$Mqtt extends $AsyncNotifier<Stream<RelayMessage>> {
  FutureOr<Stream<RelayMessage>> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref =
        this.ref
            as $Ref<AsyncValue<Stream<RelayMessage>>, Stream<RelayMessage>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<
                AsyncValue<Stream<RelayMessage>>,
                Stream<RelayMessage>
              >,
              AsyncValue<Stream<RelayMessage>>,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}
