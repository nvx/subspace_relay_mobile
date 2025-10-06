// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'mqtt.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(BrokerUrl)
const brokerUrlProvider = BrokerUrlProvider._();

final class BrokerUrlProvider extends $AsyncNotifierProvider<BrokerUrl, Uri> {
  const BrokerUrlProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'brokerUrlProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$brokerUrlHash();

  @$internal
  @override
  BrokerUrl create() => BrokerUrl();
}

String _$brokerUrlHash() => r'd06cf1f90eeb912c5242b8199bdf3020b23f92d4';

abstract class _$BrokerUrl extends $AsyncNotifier<Uri> {
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

String _$mqttHash() => r'a8fbaa306844afdd0d8f2b8a0aa5c0f5a8f7e377';

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
