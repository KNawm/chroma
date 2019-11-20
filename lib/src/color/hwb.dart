import 'dart:math' as math;

import 'package:flutter/painting.dart' show HSVColor;
import 'package:chroma/src/chroma_base.dart' show AngleUnits;

// ignore: public_member_api_docs
int fromHWB(double hue, double whiteness, double blackness,
    [double alpha = 1.0, AngleUnits angleUnit = AngleUnits.deg]) {
  double saturation, value;

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

  // Normalize values to add up to 1.0
  if (whiteness + blackness > 1) {
    var sum = whiteness + blackness;
    whiteness /= sum;
    blackness /= sum;
  }

  // See [HWB color model](https://en.wikipedia.org/wiki/HWB_color_model)
  hue = hue % 360; // [HSVColor.hue] range is [0.0, 360.0]
  saturation = 1 - whiteness / (1 - blackness);
  value = 1 - blackness;

  return HSVColor.fromAHSV(alpha, hue, saturation, value).toColor().value;
}
