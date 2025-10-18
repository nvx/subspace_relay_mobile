import 'package:convert/convert.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'package:subspace_relay_mobile/hce_screen.dart';
import 'package:subspace_relay_mobile/reader_screen.dart';
import 'package:subspace_relay_mobile/util.dart';
import 'package:subspace_relay_mobile/services/discovery.dart';
import 'package:subspace_relay_mobile/services/mqtt.dart';
import 'package:subspace_relay_mobile/services/relay_id.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  if (kDebugMode) {
    // MqttLogger.loggingOn = true;
  }
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Subspace Relay${kDebugMode ? ' (Debug)' : ''}',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blueAccent, brightness: Brightness.dark),
        brightness: Brightness.dark,
      ),
      home: const ConnectScreen(),
    );
  }
}

class ConnectScreen extends HookConsumerWidget {
  static const _pubKeyHexLength = 64;
  const ConnectScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final relayId = ref.watch(relayIdProvider).value?.relayId;
    final brokerUrl = ref.watch(brokerUrlProvider);
    final discoveryPublicKey = ref.watch(discoveryPublicKeyProvider);
    final brokerUrlTextController = useTextEditingController();
    final discoveryPublicKeyTextController = useTextEditingController();
    final initialValueLoaded = useState(false);
    final isEmpty = useState(true);
    final isValid = useState(false);
    final isDiscoveryPublicKeyValid = useState(true);
    final readyToConnect = isValid.value && !isEmpty.value && isDiscoveryPublicKeyValid.value;

    void updateValidChecks() {
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

      isDiscoveryPublicKeyValid.value = discoveryPublicKeyTextController.text.isEmpty || discoveryPublicKeyTextController.text.length == _pubKeyHexLength;
    }

    if (!initialValueLoaded.value && brokerUrl.hasValue && discoveryPublicKey.hasValue) {
      initialValueLoaded.value = true;
      if (brokerUrlTextController.text.isEmpty) {
        brokerUrlTextController.text = brokerUrl.value.toString();
      }
      if (discoveryPublicKeyTextController.text.isEmpty) {
        discoveryPublicKeyTextController.text = hex.encode(discoveryPublicKey.value!).toUpperCase();
      }
      updateValidChecks();
    }

    useEffect(() {
      brokerUrlTextController.addListener(updateValidChecks);
      return () => brokerUrlTextController.removeListener(updateValidChecks);
    }, [brokerUrlTextController]);

    useEffect(() {
      discoveryPublicKeyTextController.addListener(updateValidChecks);
      return () => discoveryPublicKeyTextController.removeListener(updateValidChecks);
    }, [discoveryPublicKeyTextController]);

    connect(WidgetBuilder builder) async {
      await ref.read(discoveryPublicKeyProvider.notifier).updatePublicKey(hex.decode(discoveryPublicKeyTextController.text));
      await ref.read(brokerUrlProvider.notifier).updateBrokerUrl(brokerUrlTextController.text);
      if (context.mounted) {
        Navigator.push(context, MaterialPageRoute(builder: builder));
      }
    }

    return Scaffold(
      appBar: AppBar(backgroundColor: Theme.of(context).colorScheme.inversePrimary, title: const Text('Subspace Relay')),
      body: SafeArea(
        child: Center(
          child: Column(
            spacing: 10,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              if (relayId != null) RelayIdWidget(relayId),
              if (relayId != null)
                ElevatedButton(
                  child: Text('New RelayID'),
                  onPressed: () {
                    ref.invalidate(relayIdProvider);
                  },
                ),
              SizedBox(
                width: 400,
                child: TextField(
                  autocorrect: false,
                  textCapitalization: TextCapitalization.none,
                  controller: brokerUrlTextController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'MQTT Broker URL',
                    errorText: isValid.value || isEmpty.value ? null : 'Invalid url',
                  ),
                ),
              ),
              SizedBox(
                width: 400,
                child: TextField(
                  autocorrect: false,
                  textCapitalization: TextCapitalization.none,
                  controller: discoveryPublicKeyTextController,
                  inputFormatters: <TextInputFormatter>[
                    UpperCaseTextFormatter(),
                    // only allow hex characters
                    FilteringTextInputFormatter.allow(RegExp("[A-F0-9]")),
                    LengthLimitingTextInputFormatter(_pubKeyHexLength),
                  ],
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Discovery Public Key (Optional)',
                    errorText: isDiscoveryPublicKeyValid.value ? null : 'Invalid public key',
                  ),
                ),
              ),
              ElevatedButton(onPressed: !readyToConnect ? null : () => connect((context) => HceRelayScreen()), child: const Text("Start HCE")),
              ElevatedButton(onPressed: !readyToConnect ? null : () => connect((context) => ReaderRelayScreen(false)), child: const Text("Start Reader")),
              ElevatedButton(
                onPressed: !readyToConnect ? null : () => connect((context) => ReaderRelayScreen(true)),
                child: const Text("Start Reader (Dynamic)"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
