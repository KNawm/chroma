import 'dart:math' as math;
import 'dart:ui' show Color;

import 'package:flutter/painting.dart' show HSLColor, HSVColor;

part 'named_colors.dart';

Color chroma(color) => Chroma.color(color);

class Chroma extends Color {
  //Chroma._();

  var test;

  Chroma(String value) : super.fromARGB(1);

  static const Color _black = Color(0xFF000000);
  static const Color _white = Color(0xFFFFFFFF);

  /*/// Returns the alpha channel of a color as an integer between 0 and 255.
  ///
  /// A value of 0 is fully transparent, and 255 is fully opaque.
  static int alpha(Color color) => color.alpha;

  /// Returns the alpha channel of a color as a double between 0 and 1.
  ///
  /// A value of 0.0 is fully transparent, and 1.0 is fully opaque.
  static double opacity(Color color) => color.opacity;

  /// Returns the red channel of a color as an integer between 0 and 255.
  static int red(Color color) => color.red;

  /// Returns the green channel of a color as an integer between 0 and 255.
  static int green(Color color) => color.green;

  /// Returns the blue channel of a color as an integer between 0 and 255.
  static int blue(Color color) => color.blue;*/

  /// TODO DOCS
  static Color color(String value) {
    value = value.toLowerCase();

    if (_isNamedColor(value)) {
      return _namedColors[value];
    } else {
      return _parseHexString(value);
    }
  }

  /// The rgb() function defines an sRGB color by specifying the red, green,
  /// blue and alpha channels directly. TODO
  ///
  /// Out of range values are clamped.
  static Color rgb(r, g, b, [a = 1.0]) {
    var red, green, blue, alpha;

    switch (r.runtimeType) {
      case int:
        red = (r as int).clamp(0, 255);
        break;
      case double:
        red = ((r as double).clamp(0.0, 1.0) * 255).round();
        break;
      default:
        throw ArgumentError('The \'r\' argument must be an int or a double.');
        break;
    }

    switch (g.runtimeType) {
      case int:
        green = (g as int).clamp(0, 255);
        break;
      case double:
        green = ((g as double).clamp(0.0, 1.0) * 255).round();
        break;
      default:
        throw ArgumentError('The \'g\' argument must be an int or a double.');
        break;
    }

    switch (b.runtimeType) {
      case int:
        blue = (b as int).clamp(0, 255);
        break;
      case double:
        blue = ((b as double).clamp(0.0, 1.0) * 255).round();
        break;
      default:
        throw ArgumentError('The \'b\' argument must be an int or a double.');
        break;
    }

    switch (a.runtimeType) {
      case int:
        alpha = (a as int).clamp(0, 255);
        break;
      case double:
        alpha = ((a as double).clamp(0.0, 1.0) * 255).round();
        break;
      default:
        throw ArgumentError('The \'a\' argument must be an int or a double.');
        break;
    }

    return Color.fromARGB(alpha, red, green, blue);
  }

  /// Alias of rgb().
  static Color rgba(r, g, b, [a = 1.0]) => rgb(r, g, b, a);

  /// TODO DOCS
  static Color hsl(double hue, double saturation, double lightness,
      [double alpha = 1.0, AngleUnits angleUnit = AngleUnits.deg]) {
    double h, s, l, a;

    // Convert to degrees
    switch (angleUnit) {
      case AngleUnits.deg:
        h = hue;
        break;
      case AngleUnits.grad:
        h = hue * 180 / 200;
        break;
      case AngleUnits.rad:
        h = hue * 180 / math.pi;
        break;
      case AngleUnits.turn:
        h = hue * 360;
        break;
      default:
        break;
    }

    h = h % 360; // [HSLColor.hue] range is [0.0, 360.0]
    s = saturation.clamp(0.0, 1.0);
    l = lightness.clamp(0.0, 1.0);
    a = alpha.clamp(0.0, 1.0);

    return HSLColor.fromAHSL(a, h, s, l).toColor();
  }

  /// Alias of hsl().
  static Color hsla(double hue, double saturation, double lightness,
          [double alpha = 1.0, AngleUnits angleUnit = AngleUnits.deg]) =>
      hsl(hue, saturation, lightness, alpha, angleUnit);

  static Color hwb(double hue, double whiteness, double blackness,
      [double alpha = 1.0, AngleUnits angleUnit = AngleUnits.deg]) {
    var w = whiteness, b = blackness;
    double h, s, v, a;

    // Convert to degrees
    switch (angleUnit) {
      case AngleUnits.deg:
        h = hue;
        break;
      case AngleUnits.grad:
        h = hue * 180 / 200;
        break;
      case AngleUnits.rad:
        h = hue * 180 / math.pi;
        break;
      case AngleUnits.turn:
        h = hue * 360;
        break;
      default:
        break;
    }

    // Normalize values to add up to 1.0
    if (w + b > 1) {
      var x = w + b;
      w /= x;
      b /= x;
    }

    // See [HWB color model](https://en.wikipedia.org/wiki/HWB_color_model)
    h = h % 360; // [HSVColor.hue] range is [0.0, 360.0]
    s = 1 - w / (1 - b);
    v = 1 - b;
    a = alpha.clamp(0.0, 1.0);

    return HSVColor.fromAHSV(a, h, s, v).toColor();
  }

  /// Alias of hwb().
  static Color hwba(double hue, double whiteness, double blackness,
          [double alpha = 1.0, AngleUnits angleUnit = AngleUnits.deg]) =>
      hwb(hue, whiteness, blackness, alpha, angleUnit);

  static bool _isNamedColor(String value) => _namedColors.containsKey(value);

  static bool _isAsciiHexDigit(int c) =>
      (c >= 97 && c <= 102) || (c >= 65 && c <= 70) || (c >= 48 && c <= 57);

  static Color _parseHexString(String value) {
    int r, g, b, a;
    var hexString = value.replaceFirst('#', '');

    if ((hexString.length != 3 &&
            hexString.length != 4 &&
            hexString.length != 6 &&
            hexString.length != 8) ||
        !hexString.codeUnits.every(_isAsciiHexDigit)) {
      throw FormatException('Could not parse hex color \'$value\'');
    }

    a = 255; // Suppose it's an opaque color. If not we change this below.

    if (hexString.length >= 6) {
      r = int.parse(hexString.substring(0, 2), radix: 16);
      g = int.parse(hexString.substring(2, 4), radix: 16);
      b = int.parse(hexString.substring(4, 6), radix: 16);
      if (hexString.length == 8) {
        a = int.parse(hexString.substring(6, 8), radix: 16);
      }
    } else {
      r = int.parse(hexString.substring(0, 1) * 2, radix: 16);
      g = int.parse(hexString.substring(1, 2) * 2, radix: 16);
      b = int.parse(hexString.substring(2, 3) * 2, radix: 16);
      if (hexString.length == 4) {
        a = int.parse(hexString.substring(3, 4) * 2, radix: 16);
      }
    }

    return Color.fromARGB(a, r, g, b);
  }

  /// Generate a random fully opaque color.
  static Color random() {
    const hexMax = 256 * 256 * 256;
    var color = (math.Random().nextDouble() * hexMax).floor();
    return Color(color + 0xFF000000);
  }

  static Color contrastColor(Color color) {
    var r = color.red;
    var g = color.green;
    var b = color.blue;

    // See <https://www.w3.org/TR/AERT/#color-contrast>
    return ((r * 299) + (g * 587) + (b * 114)) / 1000 > 125 ? _black : _white;
  }

  /// Returns a CSS string of a color.
  ///
// TODO implement
/*
  @override
  // HEX, RGB, CMYK, HSV, HSL
  String toString([{enum color space}]) {
    return 'asd';
  }
   */
}

enum AngleUnits { deg, grad, rad, turn }
