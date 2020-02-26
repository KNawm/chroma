import 'utils.dart' show toColorValue;

List fromRGB(double red, double green, double blue, [double alpha = 1.0]) {
  assert(red >= 0.0);
  assert(red <= 255.0);
  assert(green >= 0.0);
  assert(green <= 255.0);
  assert(blue >= 0.0);
  assert(blue <= 255.0);
  assert(alpha >= 0.0);
  assert(alpha <= 1.0);

  final out = List(2)
    ..[0] = toColorValue(red, green, blue, alpha)
    ..[1] = {
      'r': red,
      'g': green,
      'b': blue,
      'a': alpha,
    };

  return out;
}
