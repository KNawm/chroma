import 'dart:math' as math show pi;

import 'package:chroma/src/chroma_base.dart' show AngleUnits;

// Bound values in the range [0, 255] to [0.0, 1.0]
double bound(num value) {
  return value / 0xFF;
}

// Returns a 32 bit value representing a color with the specified components.
// Parameters range is [0.0, 1.0]
int toColorValue(double red, double green, double blue, double alpha) {
  final r = (red * 0xFF).round();
  final g = (green * 0xFF).round();
  final b = (blue * 0xFF).round();
  final a = (alpha * 0xFF).round();

  return (a << 24) | (r << 16) | (g << 8) | (b << 0);
}

double convertToDegrees(double value, AngleUnits unit) {
  switch (unit) {
    case AngleUnits.grad:
      return value * 180 / 200;
    case AngleUnits.rad:
      return value * 180 / math.pi;
    case AngleUnits.turn:
      return value * 360;
    default:
      return value;
  }
}
