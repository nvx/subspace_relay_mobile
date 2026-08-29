import 'package:convert/convert.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'package:subspace_relay_mobile/connection_mode.dart';
import 'package:subspace_relay_mobile/favorites_screen.dart';
import 'package:subspace_relay_mobile/history_screen.dart';
import 'package:subspace_relay_mobile/util.dart';
import 'package:subspace_relay_mobile/services/discovery.dart';
import 'package:subspace_relay_mobile/services/favorites.dart';
import 'package:subspace_relay_mobile/services/history.dart';
import 'package:subspace_relay_mobile/services/mqtt.dart';
import 'package:subspace_relay_mobile/services/relay_id.dart';

class ConnectScreen extends HookConsumerWidget {
  const ConnectScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final relayId = ref.watch(relayIdProvider).value?.relayId;
    final brokerUrl = ref.watch(brokerUrlProvider);
    final discoveryPublicKey = ref.watch(discoveryPublicKeyProvider);
    final brokerUrlTextController = useTextEditingController();
    final discoveryPublicKeyTextController = useTextEditingController();
    final initialValueLoaded = useState(false);
    final isBrokerEmpty = useState(true);
    final isBrokerValid = useState(false);
    final isDiscoveryPublicKeyValid = useState(true);
    final readyToConnect = isBrokerValid.value && !isBrokerEmpty.value && isDiscoveryPublicKeyValid.value;

    void updateValidChecks() {
      isDiscoveryPublicKeyValid.value = discoveryPublicKeyTextController.text.isEmpty || discoveryPublicKeyTextController.text.length == pubKeyHexLength;

      isBrokerEmpty.value = brokerUrlTextController.text.isEmpty;
      if (isBrokerEmpty.value) {
        isBrokerValid.value = false;
        return;
      }

      final parsedUri = Uri.tryParse(brokerUrlTextController.text);
      if (parsedUri == null) {
        isBrokerValid.value = false;
        return;
      }

      isBrokerValid.value = ['mqtt', 'mqtts', 'ws', 'wss'].contains(parsedUri.scheme) && parsedUri.host.isNotEmpty;
    }

    // Populate text controllers from providers exactly once on initial load.
    // After this, text controllers are the source of truth — never overwritten by providers.
    if (!initialValueLoaded.value && brokerUrl.hasValue && discoveryPublicKey.hasValue) {
      initialValueLoaded.value = true;
      brokerUrlTextController.text = brokerUrl.value.toString();
      discoveryPublicKeyTextController.text = hex.encode(discoveryPublicKey.value!).toUpperCase();
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

    useEffect(() {
      updateValidChecks();
      return null;
    }, [key]);

    // Keep the text fields in sync when the broker / discovery key are changed
    // externally — e.g. a deep link scanned while this screen is backgrounded, or
    // a favorite being loaded. User edits only ever live in the controllers (they
    // aren't written back to the providers until connect), so syncing here never
    // clobbers in-progress typing.
    ref.listen(brokerUrlProvider, (previous, next) {
      if (next.hasValue && brokerUrlTextController.text != next.value.toString()) {
        brokerUrlTextController.text = next.value.toString();
        updateValidChecks();
      }
    });
    ref.listen(discoveryPublicKeyProvider, (previous, next) {
      if (next.hasValue) {
        final encoded = hex.encode(next.value!).toUpperCase();
        if (discoveryPublicKeyTextController.text != encoded) {
          discoveryPublicKeyTextController.text = encoded;
          updateValidChecks();
        }
      }
    });

    Future<void> connect(ConnectionMode mode) async {
      final dkText = discoveryPublicKeyTextController.text;
      await ref.read(discoveryPublicKeyProvider.notifier).updatePublicKey(hex.decode(dkText));
      await ref.read(brokerUrlProvider.notifier).updateBrokerUrl(brokerUrlTextController.text);
      // Resolve the relay ID before recording history so the entry has the value used for the connection.
      final resolvedRelayId = await ref.read(relayIdProvider.future);
      final historyId = await ref
          .read(connectionHistoryProvider.notifier)
          .add(brokerUrl: brokerUrlTextController.text, discoveryPublicKey: dkText, relayId: resolvedRelayId.relayId, mode: mode);
      if (context.mounted) {
        Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: widgetBuilderForMode(mode, historyId: historyId)), ModalRoute.withName('/'));
      }
    }

    Future<void> loadFavorite(Favorite fav) async {
      brokerUrlTextController.text = fav.brokerUrl;
      discoveryPublicKeyTextController.text = fav.discoveryPublicKey;
      updateValidChecks();

      // Sync providers to match the favorite
      await ref.read(discoveryPublicKeyProvider.notifier).updatePublicKey(hex.decode(fav.discoveryPublicKey));
      await ref.read(brokerUrlProvider.notifier).updateBrokerUrl(fav.brokerUrl);
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('Subspace Relay'),
        actions: [
          IconButton(
            icon: Icon(Icons.star),
            tooltip: 'Favorites',
            onPressed: () async {
              final fav = await Navigator.push<Favorite>(
                context,
                MaterialPageRoute(
                  builder: (_) =>
                      FavoritesScreen(currentBrokerUrl: brokerUrlTextController.text, currentDiscoveryPublicKey: discoveryPublicKeyTextController.text),
                ),
              );
              if (fav != null) {
                await loadFavorite(fav);
              }
            },
          ),
          IconButton(
            icon: Icon(Icons.history),
            tooltip: 'History',
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (_) => HistoryScreen()));
            },
          ),
        ],
      ),
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
                    errorText: isBrokerValid.value || isBrokerEmpty.value ? null : 'Invalid url',
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
                    LengthLimitingTextInputFormatter(pubKeyHexLength),
                  ],
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Discovery Public Key (Optional)',
                    errorText: isDiscoveryPublicKeyValid.value ? null : 'Invalid public key',
                  ),
                ),
              ),
              ElevatedButton(onPressed: !readyToConnect ? null : () => connect(ConnectionMode.hce), child: const Text("Start HCE")),
              ElevatedButton(onPressed: !readyToConnect ? null : () => connect(ConnectionMode.reader), child: const Text("Start Reader")),
              ElevatedButton(onPressed: !readyToConnect ? null : () => connect(ConnectionMode.readerDynamic), child: const Text("Start Reader (Dynamic)")),
            ],
          ),
        ),
      ),
    );
  }
}
