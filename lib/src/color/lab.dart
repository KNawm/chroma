import 'package:chroma/src/conversions.dart' show labToRgb;
import 'package:chroma/src/utils.dart' show toColorValue;

List fromLAB(double l, double a, double b, double alpha) {
  final rgb = labToRgb(l, a, b);

  final components = List<double>(4)
    ..[0] = l
    ..[1] = a
    ..[2] = b
    ..[3] = alpha;
  final format = 'lab';
  final value = toColorValue(rgb[0], rgb[1], rgb[2], alpha);

  return List(3)
    ..[0] = components
    ..[1] = format
    ..[2] = value;
}
