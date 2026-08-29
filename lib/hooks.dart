import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class _RouteCallbacks with RouteAware {
  const _RouteCallbacks({this.handleDidPopNext, this.handleDidPush, this.handleDidPop, this.handleDidPushNext});

  final Function()? handleDidPopNext;
  final Function()? handleDidPush;
  final Function()? handleDidPop;
  final Function()? handleDidPushNext;

  @override
  void didPopNext() {
    handleDidPopNext?.call();
  }

  @override
  void didPush() {
    handleDidPush?.call();
  }

  @override
  void didPop() {
    handleDidPop?.call();
  }

  @override
  void didPushNext() {
    handleDidPushNext?.call();
  }
}

void useRouteObserver(
  RouteObserver<ModalRoute> routeObserver, {
  void Function()? didPopNext,
  void Function()? didPush,
  void Function()? didPop,
  void Function()? didPushNext,
  List<Object?> keys = const [],
}) {
  final context = useContext();
  final route = ModalRoute.of(context);

  useEffect(() {
    if (route == null) return () {};

    final callbacks = _RouteCallbacks(handleDidPop: didPop, handleDidPopNext: didPopNext, handleDidPush: didPush, handleDidPushNext: didPushNext);
    routeObserver.subscribe(callbacks, route);
    return () => routeObserver.unsubscribe(callbacks);
  }, [route, routeObserver, ...keys]);
}
