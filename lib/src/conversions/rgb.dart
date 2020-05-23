import 'dart:math' as math show min, max;
import 'package:chroma/src/utils.dart' show srgbToLinear;

import 'xyz.dart';

List rgbToHsl(double red, double green, double blue) {
  double hue, saturation, lightness;

  final max = math.max(red, math.max(green, blue));
  final min = math.min(red, math.min(green, blue));
  final delta = max - min;

  lightness = (max + min) / 2;

  if(max == min) {
    hue = saturation = 0;
  } else {
    if (max == red) {
      hue = ((green - blue) / delta) % 6;
    } else if (max == green) {
      hue = ((blue - red) / delta) + 2;
    } else {
      hue = ((red - green) / delta) + 4;
    }

    saturation = delta / (1 - (2 * lightness - 1).abs());
  }

  hue = (hue * 60) % 360;
  if (hue < 0) {
    hue += 360;
  }

  return List(3)
    ..[0] = hue
    ..[1] = saturation
    ..[2] = lightness;
}

List rgbToXyz(double red, double green, double blue) {
  red = srgbToLinear(red);
  green = srgbToLinear(green);
  blue = srgbToLinear(blue);

  final x = red * 0.4124564 + green * 0.3575761 + blue * 0.1804375;
  final y = red * 0.2126729 + green * 0.7151522 + blue * 0.0721750;
  final z = red * 0.0193339 + green * 0.1191920 + blue * 0.9503041;

  return List(3)
    ..[0] = x
    ..[1] = y
    ..[2] = z;
}

List rgbToLab(double red, double green, double blue) {
  final xyz = rgbToXyz(red, green, blue);
  final x = xyz[0];
  final y = xyz[1];
  final z = xyz[2];

  final lab = xyzToLab(x, y, z);
  final l = lab[0];
  final a = lab[1];
  final b = lab[2];

  return List(3)
    ..[0] = l
    ..[1] = a
    ..[2] = b;
}
