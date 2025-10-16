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

String _$brokerUrlHash() => r'08ce380c4e069894e6bf1e7aabf5817f44b799e1';

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

String _$mqttHash() => r'bb86cf1859ebe5a64cd391dd4f574d4f4749034e';

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
