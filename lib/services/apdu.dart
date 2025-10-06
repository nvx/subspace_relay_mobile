import 'dart:typed_data';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'apdu.freezed.dart';

// Capdu is a simplified implementation that ignores Le values
@freezed
sealed class Capdu with _$Capdu {
  const factory Capdu({required int cla, required int ins, required int p1, required int p2, required Uint8List data}) = _Capdu;

  static Capdu fromBytes(Uint8List b) {
    if (b.length < 4 || b.length > 65544) {
      throw 'capdu: invalid length';
    }

    if (b.length == 4 || b.length == 5 || (b.length == 7 && b[4] == 0x00) || (b.length == 6 && b[4] == 0x00 && b[5] == 0x00)) {
      // No data
      return Capdu(cla: b[0], ins: b[1], p1: b[2], p2: b[3], data: Uint8List(0));
    }

    final bytes = b.buffer.asByteData(b.offsetInBytes);

    if (b[4] == 0x00) {
      // EXTENDED
      final bodyLen = b.length - 7;
      if (bodyLen <= 0) {
        throw 'capdu: invalid extended length with body - short';
      }

      final lc = bytes.getUint16(5);
      if (lc != bodyLen && lc != bodyLen - 2) {
        throw 'capdu: invalid extended length with body - Lc indicates length of $lc but have $bodyLen';
      }

      return Capdu(cla: b[0], ins: b[1], p1: b[2], p2: b[3], data: b.sublist(7, 7 + lc));
    }

    final bodyLen = b.length - 5;
    final lc = b[4];
    if (lc != bodyLen && lc != bodyLen - 1) {
      throw 'capdu: invalid length with body - Lc indicates length of $lc but have $bodyLen';
    }

    return Capdu(cla: b[0], ins: b[1], p1: b[2], p2: b[3], data: b.sublist(5, 5 + lc));
  }
}
