import 'package:flutter/painting.dart' show HSVColor;
import 'package:chroma/chroma.dart' show AngleUnit;
import 'package:chroma/src/utils.dart' show convertToDegrees;

List fromHSV(double h, double s, double v,
    [double a = 1.0, AngleUnit angleUnit = AngleUnit.deg]) {
  h = convertToDegrees(h, angleUnit);

  final components = List<double>(4)
    ..[0] = h
    ..[1] = s
    ..[2] = v
    ..[3] = a;
  final format = 'hsv';
  final value = HSVColor.fromAHSV(a, h, s, v).toColor().value;

  return List(3)
    ..[0] = components
    ..[1] = format
    ..[2] = value;
}
