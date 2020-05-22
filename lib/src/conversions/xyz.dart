import 'package:chroma/src/utils.dart' show linearToSrgb;

List<double> xyzToRgb(double x, double y, double z) {
  final red = linearToSrgb(3.2404542 * x - 1.5371385 * y - 0.4985314 * z);
  final green = linearToSrgb((-0.9692660) * x + 1.8760108 * y + 0.0415560 * z);
  final blue = linearToSrgb(0.0556434 * x - 0.2040259 * y + 1.0572252 * z);

  return List(3)
    ..[0] = red
    ..[1] = green
    ..[2] = blue;
}
