import 'utils.dart' show bound, toColorValue;

List fromRGB(num red, num green, num blue, [num alpha = 1.0]) {
  assert(red.runtimeType == double
      ? (red >= 0.0 && red <= 1.0)
      : (red >= 0 && red <= 255));
  assert(green.runtimeType == double
      ? (green >= 0.0 && green <= 1.0)
      : (green >= 0 && green <= 255));
  assert(blue.runtimeType == double
      ? (blue >= 0.0 && blue <= 1.0)
      : (blue >= 0 && blue <= 255));
  assert(alpha.runtimeType == double
      ? (alpha >= 0.0 && alpha <= 1.0)
      : (alpha >= 0 && alpha <= 255));

  if (red.runtimeType == int) {
    red = bound(red);
  }

  if (green.runtimeType == int) {
    green = bound(green);
  }

  if (blue.runtimeType == int) {
    blue = bound(blue);
  }

  if (alpha.runtimeType == int) {
    alpha = bound(alpha);
  }

  final out = List(2)
    ..[0] = toColorValue(red, green, blue, alpha)
    ..[1] = {
      // Make sure all components are the right type.
      'r': red.toDouble(),
      'g': green.toDouble(),
      'b': blue.toDouble(),
      'a': alpha.toDouble(),
    };

  return out;
}
