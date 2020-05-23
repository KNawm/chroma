import 'xyz.dart';

List<double> labToRgb(double l, double a, double b) {
  final xyz = labToXyz(l, a, b);
  final x = xyz[0];
  final y = xyz[1];
  final z = xyz[2];

  final rgb = xyzToRgb(x, y, z);
  final red = rgb[0];
  final green = rgb[1];
  final blue = rgb[2];

  return List(3)
    ..[0] = red
    ..[1] = green
    ..[2] = blue;
}

List<double> labToXyz(double l, double a, double b) {
  const k = 841 / 108;

  l = l.clamp(0, 100);
  a = a.clamp(-128, 128);
  b = b.clamp(-128, 128);

  final fy = (l + 16) / 116;
  final fx = fy + (a * 0.002);
  final fz = fy - (b * 0.005);
  final x = fx > 6 / 29 ? fx * fx * fx : (1 / k) * (fx - 4 / 29);
  final y = fy > 6 / 29 ? fy * fy * fy : (1 / k) * (fy - 4 / 29);
  final z = fz > 6 / 29 ? fz * fz * fz : (1 / k) * (fz - 4 / 29);

  // Uses D50 Illuminant as the reference white.
  final X = x * 0.964212;
  final Y = y * 1;
  final Z = z * 0.825188;

  return List(3)
    ..[0] = X
    ..[1] = Y
    ..[2] = Z;
}
