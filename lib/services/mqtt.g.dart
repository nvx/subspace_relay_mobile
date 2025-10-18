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
const mqttProvider = MqttFamily._();

final class MqttProvider
    extends $AsyncNotifierProvider<Mqtt, Stream<RelayMessage>> {
  const MqttProvider._({
    required MqttFamily super.from,
    required RelayId super.argument,
  }) : super(
         retry: null,
         name: r'mqttProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$mqttHash();

  @override
  String toString() {
    return r'mqttProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  Mqtt create() => Mqtt();

  @override
  bool operator ==(Object other) {
    return other is MqttProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$mqttHash() => r'c21083919d29794c8126c271893a832bd64612b0';

final class MqttFamily extends $Family
    with
        $ClassFamilyOverride<
          Mqtt,
          AsyncValue<Stream<RelayMessage>>,
          Stream<RelayMessage>,
          FutureOr<Stream<RelayMessage>>,
          RelayId
        > {
  const MqttFamily._()
    : super(
        retry: null,
        name: r'mqttProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  MqttProvider call(RelayId relayId) =>
      MqttProvider._(argument: relayId, from: this);

  @override
  String toString() => r'mqttProvider';
}

abstract class _$Mqtt extends $AsyncNotifier<Stream<RelayMessage>> {
  late final _$args = ref.$arg as RelayId;
  RelayId get relayId => _$args;

  FutureOr<Stream<RelayMessage>> build(RelayId relayId);
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build(_$args);
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
