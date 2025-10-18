import 'package:convert/convert.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:nfc_manager/nfc_manager_android.dart';

import 'package:subspace_relay_mobile/util.dart';
import 'package:subspace_relay_mobile/services/mqtt.dart';
import 'package:subspace_relay_mobile/services/relay_id.dart';
import 'package:subspace_relay_mobile/services/reader.dart';

class ReaderRelayCardInfo extends HookConsumerWidget {
  final bool _dynamicRelayId;
  final RelayId _relayId;
  final IsoDepAndroid _tag;
  const ReaderRelayCardInfo(this._dynamicRelayId, this._relayId, this._tag, {super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        if (_dynamicRelayId) RelayIdWidget(_relayId.relayId, text: 'Dynamic RelayID'),
        Text('UID: ${hex.encode(_tag.tag.id)}'),
      ],
    );
  }
}

class ReaderRelayScreen extends HookConsumerWidget {
  final bool _dynamicRelayId;
  const ReaderRelayScreen(this._dynamicRelayId, {super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final relayId = ref.watch(relayIdProvider).value;
    final readerRelay = ref.watch(readerRelayProvider(_dynamicRelayId));

    if (!_dynamicRelayId && relayId != null) {
      // keep mqtt session alive even if we lose the card briefly in non-dynamic mode
      ref.watch(mqttProvider(relayId));
    }

    return Scaffold(
      appBar: AppBar(backgroundColor: Theme.of(context).colorScheme.inversePrimary, title: const Text('Subspace Relay Reader')),
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              if (relayId != null) RelayIdWidget(relayId.relayId, text: _dynamicRelayId ? 'Base RelayID' : 'RelayID'),
              readerRelay.when(
                data: (data) => data == null ? Text('Waiting for card') : ReaderRelayCardInfo(_dynamicRelayId, data.relayId, data.tag),
                loading: () => Text('Initialising'),
                error: (error, stackTrace) => Text('Error: $error'),
              ),
              RemoteLogWidget(),
            ],
          ),
        ),
      ),
    );
  }
}
