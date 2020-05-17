import 'dart:math' as math show pi, pow;

import 'package:chroma/chroma.dart' show AngleUnit;

// Clamp values in the range [0.0, 1.0]
double clamp(double value) {
  return value.clamp(0.0, 1.0);
}

// Clamp values in the range [0.0, 255.0]
double clamp8(double value) {
  return value.clamp(0.0, 255.0);
}

// Bound values in the range [0, 255] to [0.0, 1.0]
double bound(double value) {
  return value / 0xFF;
}

// Discards the fractional part of a double if it's 0.
num checkFractional(double value) {
  if (value % 1 == 0) {
    return value.truncate().toInt();
  }

  return value;
}

// Converts a double in the range [0.0, 1.0] to [0.0, 100.0] and truncates
// the fractional part if it's 0.
num toPercentage(double value) => checkFractional(value * 100);

// Returns a 32 bit value representing a color with the specified components.
int toColorValue(int red, int green, int blue, double alpha) {
  // See <https://developer.android.com/reference/kotlin/android/graphics/Color#encoding>
  final a = (alpha * 0xFF).round();

  return (a & 0xFF) << 24 | (red & 0xFF) << 16 | (green & 0xFF) << 8 | (blue & 0xFF);
}

double srgbToLinear(num value) {
  final a = 0.055;

  if (value <= 0.04045) {
    return value / 12.92;
  }

  return math.pow((value + a) / (1 + a), 2.4);
}

double linearToSrgb(num value) {
  final a = 0.055;

  if (value <= 0.0031308) {
    return value * 12.92;
  }

  return (1 + a) * math.pow(value, 1 / 2.4) - a;
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
