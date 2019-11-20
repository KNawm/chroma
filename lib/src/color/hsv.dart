import 'dart:math' as math;

import 'package:flutter/painting.dart' show HSVColor;
import 'package:chroma/src/chroma_base.dart' show AngleUnits;

// ignore: public_member_api_docs
int fromHSV(double hue, double saturation, double value,
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

  hue = hue % 360; // [HSVColor.hue] range is [0.0, 360.0]

  return HSVColor.fromAHSV(alpha, hue, saturation, value).toColor().value;
}
