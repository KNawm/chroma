import 'package:flutter/painting.dart' show HSVColor;
import 'package:chroma/src/chroma_base.dart' show AngleUnits;

import 'utils.dart';

// ignore: public_member_api_docs
int fromHWB(double hue, double whiteness, double blackness,
    [double alpha = 1.0, AngleUnits angleUnit = AngleUnits.deg]) {
  double saturation, value;
  hue = convertToDegrees(hue, angleUnit);

  // Normalize values to add up to 1.0
  if (whiteness + blackness > 1) {
    final sum = whiteness + blackness;
    whiteness /= sum;
    blackness /= sum;
  }

  // See [HWB color model](https://en.wikipedia.org/wiki/HWB_color_model)
  hue %= 360; // [HSVColor.hue] range is [0.0, 360.0]
  saturation = 1 - whiteness / (1 - blackness);
  value = 1 - blackness;

  return HSVColor.fromAHSV(alpha, hue, saturation, value).toColor().value;
}
