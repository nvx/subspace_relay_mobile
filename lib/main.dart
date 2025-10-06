import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:subspace_relay_mobile/services/mqtt.dart';
import 'package:vibration/vibration.dart';
import 'package:mqtt5_client/mqtt5_client.dart';

import 'package:subspace_relay_mobile/services/hce.dart';
import 'package:subspace_relay_mobile/services/relay_id.dart';

void main() {
  if (kDebugMode) {
    MqttLogger.loggingOn = true;
  }
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Subspace Relay',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blueAccent, brightness: Brightness.dark),
        brightness: Brightness.dark,
      ),
      home: const ConnectScreen(),
    );
  }
}

class ConnectScreen extends HookConsumerWidget {
  const ConnectScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final relayId = ref.watch(relayIdProvider).value?.relayId;
    final brokerUrl = ref.watch(brokerUrlProvider);
    final brokerUrlTextController = useTextEditingController();
    final initialValueLoaded = useState(false);
    final isEmpty = useState(true);
    final isValid = useState(false);

    if (!initialValueLoaded.value && brokerUrl.hasValue) {
      initialValueLoaded.value = true;
      if (brokerUrlTextController.text.isEmpty) {
        brokerUrlTextController.text = brokerUrl.value.toString();
      }
    }

    brokerUrlTextController.addListener(() {
      isEmpty.value = brokerUrlTextController.text.isEmpty;
      if (isEmpty.value) {
        isValid.value = false;
        return;
      }

      final parsedUri = Uri.tryParse(brokerUrlTextController.text);
      if (parsedUri == null) {
        isValid.value = false;
        return;
      }

      isValid.value = (parsedUri.scheme == 'mqtt' || parsedUri.scheme == 'mqtts') && parsedUri.host.isNotEmpty;
    });

    connect() async {
      await ref.read(brokerUrlProvider.notifier).updateBrokerUrl(brokerUrlTextController.text);
      if (context.mounted) {
        Navigator.push(context, MaterialPageRoute(builder: (context) => HceRelayScreen()));
      }
    }

    return Scaffold(
      appBar: AppBar(backgroundColor: Theme.of(context).colorScheme.inversePrimary, title: const Text('Subspace Relay')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            if (relayId != null) Text('RelayID: $relayId'),
            if (relayId != null)
              ElevatedButton(
                child: Text('Copy'),
                onPressed: () {
                  Clipboard.setData(ClipboardData(text: relayId));
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Copied to Clipboard')));
                },
              ),
            SizedBox(
              width: 400,
              child: TextField(
                autofocus: true,
                autocorrect: false,
                textCapitalization: TextCapitalization.none,
                controller: brokerUrlTextController,
                onSubmitted: (s) {
                  if (isValid.value) {
                    connect();
                  }
                },
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'MQTT Broker URL',
                  errorText: isValid.value || isEmpty.value ? null : 'Invalid url',
                ),
              ),
            ),
            ElevatedButton(onPressed: !isValid.value || isEmpty.value ? null : connect, child: const Text("Connect")),
          ],
        ),
      ),
    );
  }
}

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
                HceState.connected => Icon(Icons.directions_run, color: Colors.greenAccent),
                HceState.idle => Icon(Icons.pending, color: Colors.yellowAccent),
                _ => Icon(Icons.question_mark, color: Theme.of(context).colorScheme.error),
              },
              error: (_, _) => Icon(Icons.error, color: Theme.of(context).colorScheme.error),
              loading: () => Transform.scale(scale: 0.5, child: const CircularProgressIndicator()),
            ),
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('HCE is ${hceActive ? 'active' : 'inactive'}'),
            relayState.when(
              data: (value) => Text('Status: $value'),
              error: (error, stackTrace) => Text('Error during relay setup: $error\n$stackTrace'),
              loading: () => const Text('Relay connecting to MQTT server'),
            ),
            if (relayId != null) Text('RelayID: $relayId'),
            if (relayId != null)
              ElevatedButton(
                child: Text('Copy'),
                onPressed: () {
                  Clipboard.setData(ClipboardData(text: relayId));
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Copied to Clipboard')));
                },
              ),
          ],
        ),
      ),
    );
  }
}
