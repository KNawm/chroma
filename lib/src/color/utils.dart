import 'dart:math' as math show pi;

import 'package:chroma/src/chroma_base.dart' show AngleUnits;
import 'package:convert/convert.dart';

// Parameters range is [0, 255]
// ignore: public_member_api_docs
int toColorValue(num red, num green, num blue, num alpha) {
  final r = red.round();
  final g = green.round();
  final b = blue.round();
  final a = alpha.round();

  return (a << 24) | (r << 16) | (g << 8) | (b << 0);
}

// ignore: public_member_api_docs
double convertToDegrees(double value, AngleUnits unit) {
  switch (unit) {
    case AngleUnits.grad:
      return value * 180 / 200;
    case AngleUnits.rad:
      return value * 180 / math.pi;
    case AngleUnits.turn:
      return value * 360;
    default:
      return value;
  }
}
