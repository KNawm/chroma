import 'package:flutter/painting.dart' show HSVColor;
import 'package:chroma/chroma.dart' show AngleUnits;

import 'utils.dart' show convertToDegrees;

List fromHSV(double hue, double saturation, double value,
    [double alpha = 1.0, AngleUnits angleUnit = AngleUnits.deg]) {
  assert(saturation >= 0.0);
  assert(saturation <= 1.0);
  assert(value >= 0.0);
  assert(value <= 1.0);
  assert(alpha >= 0.0);
  assert(alpha <= 1.0);

  hue = convertToDegrees(hue, angleUnit);

  final out = List(2)
    ..[0] = HSVColor.fromAHSV(alpha, hue, saturation, value).toColor().value
    ..[1] = {
      'h': hue,
      's': saturation,
      'v': value,
      'a': alpha,
    };

  return out;
}
