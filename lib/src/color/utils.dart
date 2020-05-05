import 'dart:math' as math show pi;

import 'package:chroma/chroma.dart' show AngleUnit;

// Bound values in the range [0, 255] to [0.0, 1.0]
double bound(num value) {
  return value / 0xFF;
}

// If the fractional part of a double is 0, discard it.
num checkFractional(double n) {
  if (n % 1 == 0) {
    return n.truncate();
  }

  return n;
}

// Converts a double in the range [0.0, 1.0] to [0.0, 100.0] and truncates
// the fractional part if it's 0.
num toPercentage(double n) => checkFractional(n * 100);

// Returns a 32 bit value representing a color with the specified components.
int toColorValue(double red, double green, double blue, double alpha) {
  // See <https://developer.android.com/reference/kotlin/android/graphics/Color#encoding>
  final r = red.round();
  final g = green.round();
  final b = blue.round();
  final a = (alpha * 0xFF).round();

  return (a & 0xFF) << 24 | (r & 0xFF) << 16 | (g & 0xFF) << 8 | (b & 0xFF);
}

// Convert angle to degree and normalize it in the range [0.0, 360.0)
double convertToDegrees(double value, AngleUnit unit) {
  switch (unit) {
    case AngleUnit.grad:
      return (value * 180 / 200) % 360;
    case AngleUnit.rad:
      return (value * 180 / math.pi) % 360;
    case AngleUnit.turn:
      return (value * 360) % 360;
    default:
      return value % 360;
  }
}
