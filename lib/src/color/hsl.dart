import 'package:flutter/painting.dart' show HSLColor;
import 'package:chroma/chroma.dart' show AngleUnit;
import 'package:chroma/src/utils.dart' show convertToDegrees;

List fromHSL(double hue, double saturation, double lightness,
    [double alpha = 1.0, AngleUnit angleUnit = AngleUnit.deg]) {
  hue = convertToDegrees(hue, angleUnit);

  final components = List<double>(4)
    ..[0] = hue
    ..[1] = saturation
    ..[2] = lightness
    ..[3] = alpha;
  final format = 'hsl';
  final value = HSLColor.fromAHSL(alpha, hue, saturation, lightness).toColor().value;

  return List(3)
    ..[0] = components
    ..[1] = format
    ..[2] = value;
}
