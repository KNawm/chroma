import 'package:flutter/painting.dart' show HSVColor;
import 'package:chroma/chroma.dart' show AngleUnit;

import '../utils.dart' show convertToDegrees;

List fromHWB(double hue, double whiteness, double blackness,
    [double alpha = 1.0, AngleUnit angleUnit = AngleUnit.deg]) {
  assert(whiteness >= 0.0);
  assert(whiteness <= 1.0);
  assert(blackness >= 0.0);
  assert(blackness <= 1.0);
  assert(alpha >= 0.0);
  assert(alpha <= 1.0);

  double saturation, value;
  hue = convertToDegrees(hue, angleUnit);

  // Normalize values to add up to 1.0
  if (whiteness + blackness > 1) {
    final sum = whiteness + blackness;
    whiteness /= sum;
    blackness /= sum;
  }

  // See <https://en.wikipedia.org/wiki/HWB_color_model>
  saturation = 1 - whiteness / (1 - blackness);
  value = 1 - blackness;

  final out = List(2)
    ..[0] = HSVColor.fromAHSV(alpha, hue, saturation, value).toColor().value
    ..[1] = {
      'h': hue,
      'w': whiteness,
      'b': blackness,
      'a': alpha,
    };

  return out;
}
