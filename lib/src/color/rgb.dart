import 'package:chroma/src/utils.dart' show toColorValue;

List fromRGB(double red, double green, double blue, [double alpha = 1.0]) {
  final components = List<double>(4)
    ..[0] = red / 0xFF
    ..[1] = green / 0xFF
    ..[2] = blue / 0xFF
    ..[3] = alpha;
  final format = 'rgb';
  final value = toColorValue(components[0], components[1], components[2], components[3]);

  return List(3)
    ..[0] = components
    ..[1] = format
    ..[2] = value;
}
