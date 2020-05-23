import 'package:chroma/src/utils.dart' show toColorValue;

List hslToRgb(double hue, double saturation, double lightness, double alpha) {
  double red, green, blue;

  final chroma = (1 - (2 * lightness - 1).abs()) * saturation;
  final match = lightness - 0.5 * chroma;
  final secondary = chroma * (1 - (((hue / 60) % 2.0) - 1.0).abs());
  final hueSegment = hue ~/ 60;

  switch (hueSegment) {
    case 0:
      red = chroma + match;
      green = secondary + match;
      blue = match;
      break;
    case 1:
      red = secondary + match;
      green = chroma + match;
      blue = match;
      break;
    case 2:
      red = match;
      green = chroma + match;
      blue = secondary + match;
      break;
    case 3:
      red = match;
      green = secondary + match;
      blue = chroma + match;
      break;
    case 4:
      red = secondary + match;
      green = match;
      blue = chroma + match;
      break;
    case 5:
    case 6:
      red = chroma + match;
      green = match;
      blue = secondary + match;
      break;
  }

  final components = List<double>(4)
    ..[0] = red
    ..[1] = green
    ..[2] = blue
    ..[3] = alpha;
  final format = 'rgb';
  final value = toColorValue(red, green, blue, alpha);

  return List(3)
    ..[0] = components
    ..[1] = format
    ..[2] = value;
}
