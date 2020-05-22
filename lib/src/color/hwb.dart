import 'package:flutter/painting.dart' show HSVColor;
import 'package:chroma/chroma.dart' show AngleUnit;
import 'package:chroma/src/utils.dart' show convertToDegrees;

List fromHWB(double hue, double whiteness, double blackness,
    [double alpha = 1.0, AngleUnit angleUnit = AngleUnit.deg]) {
  double s, v;
  hue = convertToDegrees(hue, angleUnit);

  // Normalize values to add up to 1.0
  if (whiteness + blackness > 1) {
    final sum = whiteness + blackness;
    whiteness /= sum;
    blackness /= sum;
  }

  // See <https://en.wikipedia.org/wiki/HWB_color_model>
  s = 1 - whiteness / (1 - blackness);
  v = 1 - blackness;

  final components = List<double>(4)
    ..[0] = hue
    ..[1] = whiteness
    ..[2] = blackness
    ..[3] = alpha;
  final format = 'hwb';
  final value = HSVColor.fromAHSV(alpha, hue, s, v).toColor().value;

  return List(3)
    ..[0] = components
    ..[1] = format
    ..[2] = value;
}
