import 'package:convert/convert.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';

import 'package:subspace_relay_mobile/favorites_screen.dart';
import 'package:subspace_relay_mobile/history_screen.dart';
import 'package:subspace_relay_mobile/util.dart';
import 'package:subspace_relay_mobile/hooks.dart';
import 'package:subspace_relay_mobile/services/discovery.dart';
import 'package:subspace_relay_mobile/services/favorites.dart';
import 'package:subspace_relay_mobile/services/history.dart';
import 'package:subspace_relay_mobile/services/log.dart';
import 'package:subspace_relay_mobile/services/mqtt.dart';
import 'package:subspace_relay_mobile/services/prefs.dart';
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
    final currentHistoryId = useState<String?>(null);
    final isBrokerEmpty = useState(true);
    final isBrokerValid = useState(false);
    final isDiscoveryPublicKeyValid = useState(true);
    final readyToConnect = isBrokerValid.value && !isBrokerEmpty.value && isDiscoveryPublicKeyValid.value;

    if (kDebugMode) {
      print('build: readyToConnect=$readyToConnect broker="${brokerUrlTextController.text}" discoveryLen=${discoveryPublicKeyTextController.text.length}');
    }

    void updateValidChecks() {
      final dkText = discoveryPublicKeyTextController.text;
      isDiscoveryPublicKeyValid.value = dkText.isEmpty || dkText.length == pubKeyHexLength;

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

    useRouteObserver(
      routeObserver,
      didPopNext: () async {
        if (kDebugMode) {
          print('didPopNext: currentHistoryId=${currentHistoryId.value}');
        }
        // Save remote log to history entry when returning from a connection screen
        final historyId = currentHistoryId.value;
        if (historyId != null) {
          final logEntries = ref.read(remoteLogProvider);
          if (kDebugMode) {
            print('Saving log for $historyId: ${logEntries.length} entries');
          }
          if (logEntries.isNotEmpty) {
            final logText = logEntries.map((e) => '[${DateFormat('HH:mm:ss').format(e.timestamp)}] ${e.message}').join('\n');
            await ref.read(connectionHistoryProvider.notifier).updateLog(historyId, logText);
          }
          currentHistoryId.value = null;
          // Do NOT reset initialValueLoaded here — text controllers already have
          // the correct values and must not be overwritten by stale provider state.
        }
      },
    );

    connect(ConnectionMode mode) async {
      if (kDebugMode) {
        print('connect: broker="${brokerUrlTextController.text}" dkLen=${discoveryPublicKeyTextController.text.length}');
      }
      try {
        final dkText = discoveryPublicKeyTextController.text.trim();
        await ref.read(discoveryPublicKeyProvider.notifier).updatePublicKey(dkText.isEmpty ? [] : hex.decode(dkText));
        await ref.read(brokerUrlProvider.notifier).updateBrokerUrl(brokerUrlTextController.text.trim());
        ref.invalidate(remoteLogProvider);
        // Await the relay ID to ensure it's resolved before recording history
        final resolvedRelayId = await ref.read(relayIdProvider.future);
        final historyId = await ref.read(connectionHistoryProvider.notifier).add(
              brokerUrl: brokerUrlTextController.text.trim(),
              discoveryPublicKey: dkText,
              relayId: resolvedRelayId.relayId,
              mode: mode,
            );
        currentHistoryId.value = historyId;
        if (kDebugMode) {
          print('connect: navigating, historyId=$historyId relayId=${resolvedRelayId.relayId}');
        }
        if (context.mounted) {
          Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: widgetBuilderForMode(mode)), ModalRoute.withName('/'));
        }
      } catch (e, st) {
        if (kDebugMode) {
          print('connect error: $e\n$st');
        }
      }
    }

    loadFavorite(Favorite fav) async {
      if (kDebugMode) {
        print('loadFavorite: name=${fav.name} broker=${fav.brokerUrl} dkLen=${fav.discoveryPublicKey.length} relayId=${fav.relayId}');
      }
      brokerUrlTextController.text = fav.brokerUrl;
      discoveryPublicKeyTextController.text = fav.discoveryPublicKey;
      updateValidChecks();

      // Sync providers to match the favorite
      final dkText = fav.discoveryPublicKey.trim();
      await ref.read(discoveryPublicKeyProvider.notifier).updatePublicKey(dkText.isEmpty ? [] : hex.decode(dkText));
      await ref.read(brokerUrlProvider.notifier).updateBrokerUrl(fav.brokerUrl);

      // Load the favorite's relay ID (or keep the current one)
      if (fav.relayId.isNotEmpty) {
        await ref.read(prefsProvider).setString(kPrefsRelayId, fav.relayId);
        ref.invalidate(relayIdProvider);
      }

      if (kDebugMode) {
        print('loadFavorite done: isBrokerValid=${isBrokerValid.value} isBrokerEmpty=${isBrokerEmpty.value} isDiscoveryPublicKeyValid=${isDiscoveryPublicKeyValid.value}');
      }
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
              final currentRelayId = ref.read(relayIdProvider).value?.relayId ?? '';
              final fav = await Navigator.push<Favorite>(
                context,
                MaterialPageRoute(
                  builder: (_) => FavoritesScreen(
                    currentBrokerUrl: brokerUrlTextController.text,
                    currentDiscoveryPublicKey: discoveryPublicKeyTextController.text,
                    currentRelayId: currentRelayId,
                  ),
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
                  onPressed: () async {
                    final newId = Uuid().v7().replaceAll('-', '');
                    await ref.read(prefsProvider).setString(kPrefsRelayId, newId);
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
              ElevatedButton(
                onPressed: !readyToConnect ? null : () => connect(ConnectionMode.hce), 
                child: const Text("Start HCE")),
              ElevatedButton(
                onPressed: !readyToConnect ? null : () => connect(ConnectionMode.reader), 
                child: const Text("Start Reader")),
              ElevatedButton(
                onPressed: !readyToConnect ? null : () => connect(ConnectionMode.readerDynamic),
                child: const Text("Start Reader (Dynamic)"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
