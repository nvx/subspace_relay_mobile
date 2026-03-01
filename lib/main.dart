import 'package:convert/convert.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:hooks_riverpod/misc.dart';
import 'package:app_links/app_links.dart';

import 'package:subspace_relay_mobile/connect_screen.dart';
import 'package:subspace_relay_mobile/util.dart';
import 'package:subspace_relay_mobile/services/discovery.dart';
import 'package:subspace_relay_mobile/services/history.dart';
import 'package:subspace_relay_mobile/services/mqtt.dart';
import 'package:subspace_relay_mobile/services/relay_id.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  if (kDebugMode) {
    // MqttLogger.loggingOn = true;
  }
  runApp(ProviderScope(observers: kDebugMode ? [DebugObserver()] : [], child: MyApp()));
}

class MyApp extends HookConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final navigatorKey = useMemoized(() => GlobalKey<NavigatorState>());

    useEffect(() {
      final subscription = AppLinks().uriLinkStream.listen((uri) async {
        if (kDebugMode) {
          print('onAppLink: $uri');
        }

        final tlsDisabled = uri.queryParameters['tls'] == 'false';
        final websocket = uri.queryParameters['websocket'] == 'true';

        String scheme = "mqtts";
        if (tlsDisabled) {
          if (websocket) {
            scheme = 'ws';
          } else {
            scheme = 'mqtt';
          }
        } else if (websocket) {
          scheme = 'wss';
        }

        final params = Map<String, dynamic>.from(uri.queryParametersAll);
        params.remove('tls');
        params.remove('websocket');
        params.remove('path');
        params.remove('discovery');

        final deepLinkName = uri.queryParameters['name'];
        params.remove('name');

        final brokerUrl = Uri(
          scheme: scheme,
          userInfo: uri.userInfo,
          host: uri.host,
          port: uri.hasPort ? uri.port : null,
          path: uri.queryParameters['path'],
          queryParameters: params.isNotEmpty ? params : null,
        );

        final pubKey = uri.queryParameters['discovery'];
        if (pubKey != null) {
          if (pubKey.length == pubKeyHexLength) {
            try {
              await ref.read(discoveryPublicKeyProvider.notifier).updatePublicKey(hex.decode(pubKey));
            } catch (error) {
              if (kDebugMode) {
                print('failed to parse public key from deep link: $error');
              }
            }
          } else if (pubKey.isEmpty) {
            await ref.read(discoveryPublicKeyProvider.notifier).updatePublicKey([]);
          }
        }

        if (brokerUrl.host.isNotEmpty) {
          await ref.read(brokerUrlProvider.notifier).updateBrokerUrl(brokerUrl.toString());
        }

        if (!context.mounted) {
          return;
        }

        connect(ConnectionMode mode) async {
          try {
            final currentRelayId = (await ref.read(relayIdProvider.future)).relayId;
            await ref.read(connectionHistoryProvider.notifier).add(
                  brokerUrl: brokerUrl.toString(),
                  discoveryPublicKey: pubKey ?? '',
                  relayId: currentRelayId,
                  mode: mode,
                  name: deepLinkName,
                );
            if (!context.mounted) return;
            navigatorKey.currentState?.pushAndRemoveUntil(MaterialPageRoute(builder: widgetBuilderForMode(mode)), ModalRoute.withName('/'));
          } catch (e) {
            if (kDebugMode) print('Deep link connect error: $e');
          }
        }

        switch (uri.path) {
          case '/card':
            connect(ConnectionMode.hce);
          case '/reader':
            connect(ConnectionMode.reader);
          case '/reader-dynamic':
            connect(ConnectionMode.readerDynamic);
        }
      });
      return subscription.cancel;
    }, [key]);

    return MaterialApp(
      title: 'Subspace Relay${kDebugMode ? ' (Debug)' : ''}',
      navigatorKey: navigatorKey,
      navigatorObservers: <NavigatorObserver>[routeObserver],
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blueAccent, brightness: Brightness.dark),
        brightness: Brightness.dark,
      ),
      home: const ConnectScreen(),
    );
  }
}

final class DebugObserver extends ProviderObserver {
  @override
  void didAddProvider(ProviderObserverContext context, Object? value) {
    _log('Provider ${context.provider} was initialized with $value');
  }

  @override
  void didDisposeProvider(ProviderObserverContext context) {
    _log('Provider ${context.provider} was disposed');
  }

  @override
  void didUpdateProvider(ProviderObserverContext context, Object? previousValue, Object? newValue) {
    _log('Provider ${context.provider} updated from $previousValue to $newValue');
  }

  @override
  void providerDidFail(ProviderObserverContext context, Object error, StackTrace stackTrace) {
    if (error is ProviderException) {
      // The provider didn't fail directly, but instead depends on a failed provider.
      // The error was therefore already logged.
      return;
    }

    _log('Provider ${context.provider} threw $error at $stackTrace');
  }

  void _log(Object? m) {
    if (kDebugMode) {
      print(m);
    }
  }
}
