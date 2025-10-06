import 'package:collection/collection.dart';
import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:subspace_relay_pb/subspace_relay_pb.dart' as $pb;

import 'package:subspace_relay_mobile/services/apdu.dart';
import 'package:subspace_relay_mobile/services/mqtt.dart';

part 'shortcut.freezed.dart';

@Freezed(makeCollectionsUnmodifiable: false)
sealed class Shortcut with _$Shortcut {
  const Shortcut._();
  const factory Shortcut({
    required List<Uint8List> capduHeader,
    required List<Uint8List> capduData,
    required Uint8List rapdu,
    required bool sendCapdu,
    required RpcResponseMetadata? rpcResponseMetadata,
    required bool persistReconnect,
    required Set<int> usedEphemeral,
    required List<Shortcut> ephemeralChildren,
    required List<Shortcut> persistentChildren,
  }) = _Shortcut;

  static Shortcut fromPb($pb.EmulationShortcut shortcut, RpcResponseMetadata? rpcResponseMetadata) {
    final capduHeader = List<Uint8List>.unmodifiable(shortcut.capduHeader.map((v) => Uint8List.fromList(v)));
    final capduData = List<Uint8List>.unmodifiable(shortcut.capduData.map((v) => Uint8List.fromList(v)));
    return Shortcut(
      capduHeader: capduHeader,
      capduData: capduData,
      rapdu: Uint8List.fromList(shortcut.rapdu),
      sendCapdu: shortcut.sendCapdu,
      rpcResponseMetadata: rpcResponseMetadata,
      persistReconnect: shortcut.persistReconnect,
      usedEphemeral: <int>{},
      ephemeralChildren: List<Shortcut>.unmodifiable(shortcut.chainedNext.where((e) => !e.persistent).map((v) => Shortcut.fromPb(v, rpcResponseMetadata))),
      persistentChildren: List<Shortcut>.unmodifiable(shortcut.chainedNext.where((e) => e.persistent).map((v) => Shortcut.fromPb(v, rpcResponseMetadata))),
    );
  }

  bool capduMatch(Capdu capdu) {
    if (capduHeader.isNotEmpty) {
      var found = false;
      for (final v in capduHeader) {
        if (v.length != 4) {
          if (kDebugMode) {
            print('got EmulationShortcut with invalid capdu_header bytes length');
          }
          continue;
        }

        if (v[0] == capdu.cla && v[1] == capdu.ins && v[2] == capdu.p1 && v[3] == capdu.p2) {
          found = true;
          break;
        }
      }

      if (!found) {
        return false;
      }
    }

    if (capduData.isEmpty) {
      return true;
    }

    for (final v in capduData) {
      if (v.equals(capdu.data)) {
        return true;
      }
    }

    return false;
  }
}

void sortShortcuts(List<Shortcut> shortcuts) {
  insertionSort(
    shortcuts,
    compare: (a, b) {
      if (a.capduHeader.isEmpty != b.capduHeader.isEmpty) {
        if (a.capduHeader.isEmpty) {
          return 1;
        }
        return -1;
      }
      if (a.capduData.isEmpty != b.capduData.isEmpty) {
        if (a.capduData.isEmpty) {
          return 1;
        }
        return -1;
      }
      return 0;
    },
  );
}
