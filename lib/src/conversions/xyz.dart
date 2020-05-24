import 'dart:math' as math show pow;

import 'package:chroma/src/utils.dart' show linearToSrgb;

List<double> xyzToRgb(double x, double y, double z) {
  // D65 Illuminant 2° observer
  final red   = linearToSrgb(x *  3.2404542 + y * -1.5371385 + z * -0.4985314);
  final green = linearToSrgb(x * -0.9692660 + y *  1.8760108 + z *  0.0415560);
  final blue  = linearToSrgb(x *  0.0556434 + y * -0.2040259 + z *  1.0572252);

  return List(3)
    ..[0] = red
    ..[1] = green
    ..[2] = blue;
}

List<double> xyzToLab(double x, double y, double z) {
  const e = 216 / 24389;
  const k = 841 / 108;

  // Uses D50 Illuminant as the reference white.
  final X = x / 0.964212;
  final Y = y / 1;
  final Z = z / 0.825188;

  final fx = X > e ? math.pow(X, 1 / 3) : k * X + 4 / 29;
  final fy = Y > e ? math.pow(Y, 1 / 3) : k * Y + 4 / 29;
  final fz = Z > e ? math.pow(Z, 1 / 3) : k * Z + 4 / 29;

  final L = 116 * fy - 16;
  final a = 500 * (fx - fy);
  final b = 200 * (fy - fz);

  return List(3)
    ..[0] = L.clamp(0, 100)
    ..[1] = a.clamp(-128, 128)
    ..[2] = b.clamp(-128, 128);
}
