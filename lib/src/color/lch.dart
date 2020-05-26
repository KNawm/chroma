import 'package:chroma/src/conversions.dart' show lchToLab, labToRgb;
import 'package:chroma/src/utils.dart' show toColorValue;

List fromLCH(double l, double c, double h, double alpha) {
  final lab = lchToLab(l, c, h);
  final rgb = labToRgb(lab[0], lab[1], lab[2]);

  final components = List<double>(4)
    ..[0] = l
    ..[1] = c
    ..[2] = h
    ..[3] = alpha;
  final format = 'lch';
  final value = toColorValue(rgb[0], rgb[1], rgb[2], alpha);

  return List(3)
    ..[0] = components
    ..[1] = format
    ..[2] = value;
}
