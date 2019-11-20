import 'dart:math' as math;

import 'package:flutter/painting.dart' show HSLColor;
import 'package:chroma/src/chroma_base.dart' show AngleUnits;

// ignore: public_member_api_docs
int fromHSL(double hue, double saturation, double lightness,
    [double alpha = 1.0, AngleUnits angleUnit = AngleUnits.deg]) {
  // Convert to degrees
  switch (angleUnit) {
    case AngleUnits.deg:
      break;
    case AngleUnits.grad:
      hue = hue * 180 / 200;
      break;
    case AngleUnits.rad:
      hue = hue * 180 / math.pi;
      break;
    case AngleUnits.turn:
      hue = hue * 360;
      break;
  }

  hue = hue % 360; // [HSLColor.hue] range is [0.0, 360.0]

  return HSLColor.fromAHSL(alpha, hue, saturation, lightness).toColor().value;
}
