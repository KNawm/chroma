import '../utils.dart' show toColorValue, clamp;

List fromRGB(double red, double green, double blue, [double alpha = 1.0]) {
  assert(red >= 0.0);
  assert(red <= 255.0);
  assert(green >= 0.0);
  assert(green <= 255.0);
  assert(blue >= 0.0);
  assert(blue <= 255.0);
  assert(alpha >= 0.0);
  assert(alpha <= 1.0);

  final r = red.truncate().toInt();
  final g = green.truncate().toInt();
  final b = blue.truncate().toInt();
  final a = clamp(alpha);

  final out = List(2)
    ..[0] = toColorValue(r, g, b, a)
    ..[1] = {
      'r': r.toDouble(),
      'g': g.toDouble(),
      'b': b.toDouble(),
      'a': a,
    };

  return out;
}
