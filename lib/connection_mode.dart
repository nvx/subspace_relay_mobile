import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';

import 'package:subspace_relay_mobile/hce_screen.dart';
import 'package:subspace_relay_mobile/reader_screen.dart';

@JsonEnum()
enum ConnectionMode {
  hce('HCE'),
  reader('Reader'),
  readerDynamic('Reader (Dynamic)');

  final String displayName;
  const ConnectionMode(this.displayName);
}

WidgetBuilder widgetBuilderForMode(ConnectionMode mode, {String? historyId}) => switch (mode) {
  ConnectionMode.hce => (_) => HceRelayScreen(historyId: historyId),
  ConnectionMode.reader => (_) => ReaderRelayScreen(false, historyId: historyId),
  ConnectionMode.readerDynamic => (_) => ReaderRelayScreen(true, historyId: historyId),
};
