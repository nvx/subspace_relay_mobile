import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:vibration/vibration.dart';

import 'package:subspace_relay_mobile/util.dart';
import 'package:subspace_relay_mobile/services/hce.dart';
import 'package:subspace_relay_mobile/services/relay_id.dart';

class HceRelayScreen extends HookConsumerWidget {
  const HceRelayScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final relayId = ref.watch(relayIdProvider).value?.relayId;
    final relayState = ref.watch(hceRelayProvider);
    final hceActive = ref.watch(hceActiveProvider);

    ref.listen(hceRelayProvider, (old, now) async {
      if (now.value == null || old == null || !old.hasValue) {
        // don't vibrate on initial load
        return;
      }
      if (await Vibration.hasVibrator()) {
        Vibration.vibrate();
      }
    });

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('Subspace Relay HCE'),
        actions: <Widget>[
          Padding(
            padding: EdgeInsetsGeometry.all(10.0),
            child: relayState.when(
              data: (value) => switch (value) {
                HceRelayState.connected => Icon(Icons.directions_run, color: Colors.greenAccent),
                HceRelayState.idle => Icon(Icons.pending, color: Colors.yellowAccent),
                _ => Icon(Icons.question_mark, color: Theme.of(context).colorScheme.error),
              },
              error: (_, _) => Icon(Icons.error, color: Theme.of(context).colorScheme.error),
              loading: () => Transform.scale(scale: 0.5, child: const CircularProgressIndicator()),
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text('HCE is ${hceActive ? 'active' : 'inactive'}'),
              relayState.when(
                data: (value) => Text('Status: $value'),
                error: (error, stackTrace) => Text('Error during relay setup: $error\n$stackTrace'),
                loading: () => const Text('Relay connecting to MQTT server'),
              ),
              if (relayId != null) RelayIdWidget(relayId),
              RemoteLogWidget(),
            ],
          ),
        ),
      ),
    );
  }
}
