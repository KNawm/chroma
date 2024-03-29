import 'package:chroma/src/conversions.dart' show xyzToRgb;
import 'package:chroma/src/utils.dart' show toColorValue;

List fromXYZ(double x, double y, double z, double alpha) {
  final rgb = xyzToRgb(x, y, z);

  final components = List<double>(4)
    ..[0] = x
    ..[1] = y
    ..[2] = z
    ..[3] = alpha;
  final format = 'xyz';
  final value = toColorValue(rgb[0], rgb[1], rgb[2], alpha);

  return List(3)
    ..[0] = components
    ..[1] = format
    ..[2] = value;
}
