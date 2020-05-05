import 'dart:math' as math show pow, Random;
import 'dart:ui' show Color;

import 'package:flutter/rendering.dart';

import 'color/parser.dart' as parse;
import 'color/utils.dart' as utils show checkFractional, toPercentage;
import 'ops/ops.dart' as ops;

class Chroma extends Color {
  final _ColorFormats _colorFormat;
  final Map<String, double> _components;

  Chroma._(List color, _ColorFormats format)
      : _colorFormat = format,
        _components = color[1],
        super(color[0]);

  /// Creates a color by specifying red, green, blue and alpha as components.
  ///
  /// Each component is a double with a range from 0.0 to 1.0 or an integer with a range from 0 to 255.
  /// You can mix integers and doubles as you please, using 255 is equivalent to using 1.0,
  /// but be careful with the type of the number because you could end up with an
  /// unexpected color because 1.0 is not the same as 1.
  ///
  /// TODO
  /// An alpha value of 1.0 is completely opaque, and 0.0 is completely transparent.
  factory Chroma(String value) {
    assert(value.isNotEmpty);
    return Chroma._(parse.fromString(value), _ColorFormats.HEX);
  }

  /// Creates a color by specifying red, green, blue and alpha as components.
  ///
  /// Each component is a double with a range from 0.0 to 1.0 or an integer with a range from 0 to 255.
  /// You can mix integers and doubles as you please, using 255 is equivalent to using 1.0,
  /// but be careful with the type of the number because you could end up with an
  /// unexpected color because 1.0 is not the same as 1.
  ///
  /// TODO
  /// An alpha value of 1.0 is completely opaque, and 0.0 is completely transparent.
  factory Chroma.fromRGB(double red, double green, double blue,
          [double alpha = 1.0]) =>
      Chroma._(parse.fromRGB(red, green, blue, alpha), _ColorFormats.RGB);

  factory Chroma.fromHSL(double hue, double saturation, double lightness,
          [double alpha = 1.0, AngleUnits angleUnit = AngleUnits.deg]) =>
      Chroma._(parse.fromHSL(hue, saturation, lightness, alpha, angleUnit),
          _ColorFormats.HSL);

  factory Chroma.fromHSV(double hue, double saturation, double value,
          [double alpha = 1.0, AngleUnits angleUnit = AngleUnits.deg]) =>
      Chroma._(parse.fromHSV(hue, saturation, value, alpha, angleUnit),
          _ColorFormats.HSV);

  factory Chroma.fromHWB(double hue, double whiteness, double blackness,
          [double alpha = 1.0, AngleUnits angleUnit = AngleUnits.deg]) =>
      Chroma._(parse.fromHWB(hue, whiteness, blackness, alpha, angleUnit),
          _ColorFormats.HWB);

  /// Returns the values of the 4 components of the color, which components are
  /// present depends on the color model.
  ///
  /// All values, except for the hue, are doubles between 0.0 and 1.0.
  /// The hue is a double between 0.0 and 360.0.
  Map<String, double> get components => _components;

  @override
  double get opacity => components.values.elementAt(3);

  Chroma grayscale() {
    // See <https://en.wikipedia.org/wiki/Grayscale>
    final linear = 0.2126 * (red / 0xFF) +
        0.7152 * (green / 0xFF) +
        0.0722 * (blue / 0xFF);

    // Gamma correction
    final srgb = linear > 0.0031308
        ? (1.055 * math.pow(linear, 1 / 2.4) - 0.055) * 0xFF
        : 12.92 * linear * 0xFF;

    // TODO: maybe don't explicitly change the color model
    return Chroma.fromRGB(srgb, srgb, srgb, opacity);
  }

  /*/// Returns a new color that matches this color with the red channel replaced
  /// with the given value.
  @override
  Chroma withRed(num value) {
    return Color.fromARGB(alpha, r, green, blue);
  }

  /// Returns a new color that matches this color with the green channel replaced
  /// with the given value.
  @override
  Chroma withGreen(num value) {
    return Color.fromARGB(alpha, red, g, blue);
  }

  /// Returns a new color that matches this color with the blue channel replaced
  /// with the given value.
  @override
  Chroma withBlue(num value) {
    return Color.fromARGB(alpha, red, green, b);
  }

  /// Returns a new color that matches this color with the alpha channel replaced
  /// with the given value.
  @override
  Chroma withAlpha(num value) {
    return Color.fromARGB(a, red, green, blue);
  }

  /// Returns a new color that matches this color with the blue channel replaced
  /// with the given value.
  @override
  Chroma withOpacity(double value) {
    assert(opacity >= 0.0 && opacity <= 1.0);
    return withAlpha((255.0 * opacity).round());
  }*/

  /// Returns a new color that matches this color with the component replaced
  /// with the given value.
  ///
  /// All values, except for the hue, are doubles between 0.0 and 1.0
  /// The hue is a double between 0.0 and 360.0 TODO
  Chroma withValue(String component, double value) {
    final c = List.from(components.values);

    if (_colorFormat == _ColorFormats.HEX) {
      if (component == 'r' ||
          component == 'R' ||
          component == 'red' ||
          component == 'RED') {
        return Chroma.fromRGB(value, c[1], c[2], c[3]);
      } else if (component == 'g' ||
          component == 'G' ||
          component == 'green' ||
          component == 'GREEN') {
        return Chroma.fromRGB(c[0], value, c[2], c[3]);
      } else if (component == 'b' ||
          component == 'B' ||
          component == 'blue' ||
          component == 'BLUE') {
        return Chroma.fromRGB(c[0], c[1], value, c[3]);
      } else if (component == 'a' ||
          component == 'A' ||
          component == 'alpha' ||
          component == 'ALPHA') {
        return Chroma.fromRGB(c[0], c[1], c[2], value);
      }
    } else if (_colorFormat == _ColorFormats.RGB) {
      if (component == 'r' ||
          component == 'R' ||
          component == 'red' ||
          component == 'RED') {
        return Chroma.fromRGB(value, c[1], c[2], c[3]);
      } else if (component == 'g' ||
          component == 'G' ||
          component == 'green' ||
          component == 'GREEN') {
        return Chroma.fromRGB(c[0], value, c[2], c[3]);
      } else if (component == 'b' ||
          component == 'B' ||
          component == 'blue' ||
          component == 'BLUE') {
        return Chroma.fromRGB(c[0], c[1], value, c[3]);
      } else if (component == 'a' ||
          component == 'A' ||
          component == 'alpha' ||
          component == 'ALPHA') {
        return Chroma.fromRGB(c[0], c[1], c[2], value);
      }
    } else if (_colorFormat == _ColorFormats.HSL) {
      if (component == 'h' ||
          component == 'H' ||
          component == 'hue' ||
          component == 'HUE') {
        return Chroma.fromHSL(value, c[1], c[2], c[3]);
      } else if (component == 's' ||
          component == 'S' ||
          component == 'saturation' ||
          component == 'SATURATION') {
        return Chroma.fromHSL(c[0], value, c[2], c[3]);
      } else if (component == 'l' ||
          component == 'L' ||
          component == 'lightness' ||
          component == 'LIGHTNESS') {
        return Chroma.fromHSL(c[0], c[1], value, c[3]);
      } else if (component == 'a' ||
          component == 'A' ||
          component == 'alpha' ||
          component == 'ALPHA') {
        return Chroma.fromHSL(c[0], c[1], c[2], value);
      }
    } else if (_colorFormat == _ColorFormats.HSV) {
      if (component == 'h' ||
          component == 'H' ||
          component == 'hue' ||
          component == 'HUE') {
        return Chroma.fromHSV(value, c[1], c[2], c[3]);
      } else if (component == 's' ||
          component == 'S' ||
          component == 'saturation' ||
          component == 'SATURATION') {
        return Chroma.fromHSV(c[0], value, c[2], c[3]);
      } else if (component == 'v' ||
          component == 'V' ||
          component == 'value' ||
          component == 'VALUE') {
        return Chroma.fromHSV(c[0], c[1], value, c[3]);
      } else if (component == 'a' ||
          component == 'A' ||
          component == 'alpha' ||
          component == 'ALPHA') {
        return Chroma.fromHSV(c[0], c[1], c[2], value);
      }
    } else if (_colorFormat == _ColorFormats.HWB) {
      if (component == 'h' ||
          component == 'H' ||
          component == 'hue' ||
          component == 'HUE') {
        return Chroma.fromHWB(value, c[1], c[2], c[3]);
      } else if (component == 's' ||
          component == 'S' ||
          component == 'whiteness' ||
          component == 'WHITENESS') {
        return Chroma.fromHWB(c[0], value, c[2], c[3]);
      } else if (component == 'v' ||
          component == 'V' ||
          component == 'blackness' ||
          component == 'BLACKNESS') {
        return Chroma.fromHWB(c[0], c[1], value, c[3]);
      } else if (component == 'a' ||
          component == 'A' ||
          component == 'alpha' ||
          component == 'ALPHA') {
        return Chroma.fromHWB(c[0], c[1], c[2], value);
      }
    }
  }

  Chroma lerp(Chroma color1, Chroma color2, [double ratio = 0.5]) {
    if (_colorFormat == _ColorFormats.HEX) {
      return 'hex';
    } else if (_colorFormat == _ColorFormats.RGB) {
      return 'rgb';
    } else if (_colorFormat == _ColorFormats.HSL) {
      return 'hsl';
    } else if (_colorFormat == _ColorFormats.HSV) {
      return 'hsv';
    } else if (_colorFormat == _ColorFormats.HWB) {
      return 'hwb';
    }
  }

  String get format {
    if (_colorFormat == _ColorFormats.HEX) {
      return 'hex';
    } else if (_colorFormat == _ColorFormats.RGB) {
      return 'rgb';
    } else if (_colorFormat == _ColorFormats.HSL) {
      return 'hsl';
    } else if (_colorFormat == _ColorFormats.HSV) {
      return 'hsv';
    } else if (_colorFormat == _ColorFormats.HWB) {
      return 'hwb';
    }
  }

  /// Returns a random fully opaque color.
  static Chroma random() {
    const hexMax = 256 * 256 * 256;
    final color = (math.Random().nextDouble() * hexMax)
        .floor()
        .toRadixString(16)
        .padLeft(6, '0');
    return Chroma(color);
  }

  /// Returns the contrast ratio between 2 colors based on the WCAG 2.1 Standard
  /// as a double with a range from 1.0 to 21.0
  static double contrast(Chroma foreground, Chroma background) {
    var lighter, darker;
    final luminanceFg = foreground.computeLuminance();
    final luminanceBg = background.computeLuminance();

    if (luminanceBg > luminanceFg) {
      lighter = luminanceBg;
      darker = luminanceFg;
    } else {
      lighter = luminanceFg;
      darker = luminanceBg;
    }

    // See <https://www.w3.org/TR/WCAG21/#dfn-contrast-ratio>
    return double.parse(
        ((lighter + 0.05) / (darker + 0.05)).toStringAsFixed(2));
  }

  /*
  static double difference() {
    // TODO: <https://en.wikipedia.org/wiki/color_difference>
  }
  */

  String toCssString() {
    if (_colorFormat == _ColorFormats.HEX) {
      // TODO: support short hex output whenever possible
      var hexString = red.toRadixString(16).padLeft(2, '0') +
          green.toRadixString(16).padLeft(2, '0') +
          blue.toRadixString(16).padLeft(2, '0');
      if (alpha != 0xFF) {
        hexString += alpha.toRadixString(16).padLeft(2, '0');
      }
      return '#$hexString';
    } else if (_colorFormat == _ColorFormats.RGB) {
      final a = components.values.elementAt(3);
      return alpha != 0xFF
          ? 'rgba($red, $green, $blue, $a)'
          : 'rgb($red, $green, $blue)';
    } else if (_colorFormat == _ColorFormats.HSL) {
      final h = utils.checkFractional(components.values.elementAt(0));
      final s = utils.toPercentage(components.values.elementAt(1));
      final l = utils.toPercentage(components.values.elementAt(2));
      final a = components.values.elementAt(3);
      return alpha != 0xFF ? 'hsla($h, $s%, $l%, $a)' : 'hsl($h, $s%, $l%)';
    } else if (_colorFormat == _ColorFormats.HSV) {
      final h = utils.checkFractional(components.values.elementAt(0));
      final s = utils.toPercentage(components.values.elementAt(1));
      final v = utils.toPercentage(components.values.elementAt(2));
      final a = components.values.elementAt(3);
      return alpha != 0xFF ? 'hsv($h, $s%, $v%, $a)' : 'hsv($h, $s%, $v%)';
    } else if (_colorFormat == _ColorFormats.HWB) {
      final h = utils.checkFractional(components.values.elementAt(0));
      final w = utils.toPercentage(components.values.elementAt(1));
      final b = utils.toPercentage(components.values.elementAt(2));
      final a = components.values.elementAt(3);
      return alpha != 0xFF ? 'hwb($h, $w%, $b%, $a)' : 'hwb($h, $w%, $b%)';
    }
  }

  @override
  String toString() {
    var hex = value.toRadixString(16).padLeft(8, '0').substring(2);

    if (alpha != 0xFF) {
      hex += alpha.toRadixString(16).padLeft(2, '0');
    }

    return 'Chroma(\'#$hex\')';
  }
}

// TODO: support LAB, HCL (LCH), CMYK, HCG.
// ignore: constant_identifier_names
enum _ColorFormats { HEX, RGB, HSL, HSV, HWB }

enum AngleUnits { deg, grad, rad, turn }
