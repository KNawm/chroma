import 'package:flutter/painting.dart' show HSLColor;
import 'package:chroma/chroma.dart' show AngleUnits;

import 'utils.dart' show convertToDegrees;

List fromHSL(double hue, double saturation, double lightness,
    [double alpha = 1.0, AngleUnits angleUnit = AngleUnits.deg]) {
  assert(saturation >= 0.0);
  assert(saturation <= 1.0);
  assert(lightness >= 0.0);
  assert(lightness <= 1.0);
  assert(alpha >= 0.0);
  assert(alpha <= 1.0);

  hue = convertToDegrees(hue, angleUnit);

  final out = List(2)
    ..[0] = HSLColor.fromAHSL(alpha, hue, saturation, lightness).toColor().value
    ..[1] = {
      'h': hue,
      's': saturation,
      'l': lightness,
      'a': alpha,
    };

  return out;
}
