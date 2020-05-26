import 'dart:math' as math show atan2, sqrt, pi, pow;
import 'package:chroma/src/utils.dart' show clamp8;
import 'xyz.dart';

List<double> labToRgb(double l, double a, double b) {
  final xyz = labToXyz(l, a, b);
  final x = xyz[0];
  final y = xyz[1];
  final z = xyz[2];

  // Bradford-adapted to D65.
  final X = x *  0.9555766 + y * -0.0230393 + z * 0.0631636;
  final Y = x * -0.0282895 + y *  1.0099416 + z * 0.0210077;
  final Z = x *  0.0122982 + y * -0.0204830 + z * 1.3299098;

  final rgb = xyzToRgb(X, Y, Z);
  final red = rgb[0];
  final green = rgb[1];
  final blue = rgb[2];

  return List(3)
    ..[0] = clamp8(red)
    ..[1] = clamp8(green)
    ..[2] = clamp8(blue);
}

List<double> labToXyz(double l, double a, double b) {
  const e = 216 / 24389;
  const k = 24389 / 27;

  l = l.clamp(0, 100).toDouble();
  a = a.clamp(-128, 128).toDouble();
  b = b.clamp(-128, 128).toDouble();

  final fy = (l + 16) / 116;
  final fx = fy + (a * 0.002);
  final fz = fy - (b * 0.005);
  final fx3 = fx * fx * fx;
  final fz3 = fz * fz * fz;
  final x = fx3 > e ? fx3 : (fx * 116 - 16) / k;
  final y = l > e * k ? math.pow(fy, 3) : l / k;
  final z = fz3 > e ? fz3 : (fz * 116 - 16) / k;

  // Uses D50 Illuminant as the reference white.
  var X = x * 0.964212;
  var Y = y * 1;
  var Z = z * 0.825188;

  return List(3)
    ..[0] = X
    ..[1] = Y
    ..[2] = Z;
}

List<double> labToLch(double l, double a, double b) {
  final L = l;
  final C = math.sqrt(a * a + b * b);
  final H = math.atan2((a * math.pi / 180), (b * math.pi / 180));

  return List(3)
    ..[0] = L
    ..[1] = C
    ..[2] = H;
}
