import 'dart:math' as math show pow, Random, sqrt;
import 'dart:ui' show Color;

import 'package:flutter/rendering.dart';

import 'parser.dart' as parse;
import 'utils.dart' as utils;

class Chroma extends Color {
  final List<double> _components;
  final String _format;

  const Chroma._(List<double> components, String format, int value)
      : _components = components,
        _format = format,
        super(value);

  /// Creates a color by specifying a 3, 4, 6 and 8-digit hexadecimal string or
  /// you can use any of the 148 named CSS colors by specifying its color keyword.
  factory Chroma(String value) {
    assert(value.isNotEmpty);

    if (parse.containsNamed(value)) {
      value = parse.fromNamed(value);
    }

    final color = parse.fromHEX(value);

    return Chroma._(color[0], color[1], color[2]);
  }

  /// Creates a color by specifying [red], [green], [blue] and [opacity] as components.
  ///
  /// All components, except for the [opacity], are doubles between 0 and 255.
  /// [opacity] is the alpha channel as a double between 0.0 and 1.0.
  ///
  /// An [opacity] value of 1.0 is completely opaque, and 0.0 is completely transparent.
  factory Chroma.fromRGB(double red, double green, double blue, [double opacity = 1.0]) {
    assert(red >= 0.0);
    assert(red <= 255.0);
    assert(green >= 0.0);
    assert(green <= 255.0);
    assert(blue >= 0.0);
    assert(blue <= 255.0);
    assert(opacity >= 0.0);
    assert(opacity <= 1.0);

    final color = parse.fromRGB(red, green, blue, opacity);

    return Chroma._(color[0], color[1], color[2]);
  }

  /// Creates a color by specifying [hue], [saturation], [lightness] and [opacity] as components.
  ///
  /// All components, except for the [hue], are doubles between 0.0 and 1.0.
  /// The [hue] is a double without range as you can specify the angular unit of
  /// your preference using [angleUnit].
  ///
  /// An [opacity] value of 1.0 is completely opaque, and 0.0 is completely transparent.
  factory Chroma.fromHSL(double hue, double saturation, double lightness,
          [double opacity = 1.0, AngleUnit angleUnit = AngleUnit.deg]) {
    assert(saturation >= 0.0);
    assert(saturation <= 1.0);
    assert(lightness >= 0.0);
    assert(lightness <= 1.0);
    assert(opacity >= 0.0);
    assert(opacity <= 1.0);

    final color = parse.fromHSL(hue, saturation, lightness, opacity, angleUnit);

    return Chroma._(color[0], color[1], color[2]);
  }

  /// Creates a color by specifying [hue], [saturation], [value] and [opacity] as components.
  ///
  /// All components, except for the [hue], are doubles between 0.0 and 1.0.
  /// The [hue] is a double without range as you can specify the angular unit of
  /// your preference using [angleUnit].
  ///
  /// An [opacity] value of 1.0 is completely opaque, and 0.0 is completely transparent.
  factory Chroma.fromHSV(double hue, double saturation, double value,
          [double opacity = 1.0, AngleUnit angleUnit = AngleUnit.deg]) {
    assert(saturation >= 0.0);
    assert(saturation <= 1.0);
    assert(value >= 0.0);
    assert(value <= 1.0);
    assert(opacity >= 0.0);
    assert(opacity <= 1.0);

    final color = parse.fromHSV(hue, saturation, value, opacity, angleUnit);

    return Chroma._(color[0], color[1], color[2]);
  }

  /// Creates a color by specifying [hue], [whiteness], [blackness] and [opacity] as components.
  ///
  /// All components, except for the [hue], are doubles between 0.0 and 1.0.
  /// The [hue] is a double without range as you can specify the angular unit of
  /// your preference using [angleUnit].
  ///
  /// An [opacity] value of 1.0 is completely opaque, and 0.0 is completely transparent.
  factory Chroma.fromHWB(double hue, double whiteness, double blackness,
          [double opacity = 1.0, AngleUnit angleUnit = AngleUnit.deg]) {
    assert(whiteness >= 0.0);
    assert(whiteness <= 1.0);
    assert(blackness >= 0.0);
    assert(blackness <= 1.0);
    assert(opacity >= 0.0);
    assert(opacity <= 1.0);

    final color = parse.fromHWB(hue, whiteness, blackness, opacity, angleUnit);

    return Chroma._(color[0], color[1], color[2]);
  }

  /// Creates a color by specifying [x], [y], [z] and [opacity] as components.
  ///
  /// All components are doubles between 0.0 and 1.0.
  ///
  /// An [opacity] value of 1.0 is completely opaque, and 0.0 is completely transparent.
  factory Chroma.fromXYZ(double x, double y, double z, [double opacity = 1.0]) {
    assert(x >= 0.0);
    assert(x <= 1.0);
    assert(y >= 0.0);
    assert(y <= 1.0);
    assert(z >= 0.0);
    assert(z <= 1.0);
    assert(opacity >= 0.0);
    assert(opacity <= 1.0);

    final color = parse.fromXYZ(x, y, z, opacity);

    return Chroma._(color[0], color[1], color[2]);
  }

  factory Chroma.fromLAB(double l, double a, double b, [double opacity = 1.0]) {
    assert(l >= 0.0);
    assert(l <= 100.0);
    assert(a >= -128.0);
    assert(a <= 128.0);
    assert(b >= -128.0);
    assert(b <= 128.0);
    assert(opacity >= 0.0);
    assert(opacity <= 1.0);

    final color = parse.fromLAB(l, a, b, opacity);

    return Chroma._(color[0], color[1], color[2]);
  }

  factory Chroma.fromLCH(double lightness, double chroma, double hue, [double opacity = 1.0, AngleUnit angleUnit = AngleUnit.deg]) {
    assert(lightness >= 0.0);
    assert(lightness <= 100.0);
    assert(chroma >= 0.0);
    assert(chroma <= 132.0);
    assert(hue >= 0.0);
    assert(hue <= 360.0);
    assert(opacity >= 0.0);
    assert(opacity <= 1.0);

    final color = parse.fromLCH(lightness, chroma, hue, opacity);

    return Chroma._(color[0], color[1], color[2]);
  }

  /// Returns the values of the 4 components of the color, which components are
  /// present depends on the color model.
  ///
  /// All values, except for the hue, are doubles between 0.0 and 1.0.
  /// The hue is a double between 0 and 360.
  List<double> get components {
    if (_format == 'rgb') {
      return List(4)
        ..[0] = _components[0] * 0xFF
        ..[1] = _components[1] * 0xFF
        ..[2] = _components[2] * 0xFF
        ..[3] = _components[3];
    }

    return _components;
  }

  @override
  double get opacity => components.elementAt(3);

  /// Returns the format of the color.
  String get format => _format;

  Chroma get grayscale {
    // See <https://en.wikipedia.org/wiki/Grayscale>
    final linear = 0.2126 * (utils.srgbToLinear(red   / 0xFF)) +
                   0.7152 * (utils.srgbToLinear(green / 0xFF)) +
                   0.0722 * (utils.srgbToLinear(blue  / 0xFF));

    // Gamma compression
    final srgb = (utils.linearToSrgb(linear) * 0xFF).roundToDouble();

    // TODO: maybe don't implicitly change the color model
    return Chroma.fromRGB(srgb, srgb, srgb, opacity);
  }

  /// Returns a new color that matches this color with the alpha channel replaced
  /// with the given value. The value is an integer with a range from 0 to 255.
  @override
  Chroma withAlpha(int value) {
    assert(value >= 0 && value <= 255);
    return Chroma.fromRGB(red.toDouble(), green.toDouble(), blue.toDouble(), value / 0xFF);
  }

  /// Returns a new color that matches this color with the alpha channel replaced
  /// with the given value. The value is a double with a range from 0.0 to 1.0.
  @override
  Chroma withOpacity(double value) {
    assert(value >= 0.0 && value <= 1.0);
    return Chroma.fromRGB(red.toDouble(), green.toDouble(), blue.toDouble(), value);
  }

  /// Returns a new color that matches this color with the red channel replaced
  /// with the given value. The value is an integer with a range from 0 to 255.
  @override
  Chroma withRed(int value) {
    assert(value >= 0 && value <= 255);
    return Chroma.fromRGB(value.toDouble(), green.toDouble(), blue.toDouble(), opacity);
  }

  /// Returns a new color that matches this color with the green channel replaced
  /// with the given value. The value is an integer with a range from 0 to 255.
  @override
  Chroma withGreen(int value) {
    assert(value >= 0 && value <= 255);
    return Chroma.fromRGB(red.toDouble(), value.toDouble(), blue.toDouble(), opacity);
  }

  /// Returns a new color that matches this color with the blue channel replaced
  /// with the given value. The value is an integer with a range from 0 to 255.
  @override
  Chroma withBlue(int value) {
    assert(value >= 0 && value <= 255);
    return Chroma.fromRGB(red.toDouble(), green.toDouble(), value.toDouble(), opacity);
  }

  /// Returns a new color that matches this color with the component replaced
  /// with the given value.
  ///
  /// Red, green and blue values are doubles between 0 and 255.
  /// All other values, except for the hue, are doubles between 0.0 and 1.0.
  /// The hue is a double between 0 and 360.
  Chroma withValue(String component, double value) {
    component = component.toLowerCase();
    final c = components;

    if (_format == 'rgb') {
      if (component == 'r' || component == 'red') {
        return Chroma.fromRGB(value, green.toDouble(), blue.toDouble(), opacity);
      } else if (component == 'g' || component == 'green') {
        return Chroma.fromRGB(red.toDouble(), value, blue.toDouble(), opacity);
      } else if (component == 'b' || component == 'blue') {
        return Chroma.fromRGB(red.toDouble(), green.toDouble(), value, opacity);
      } else if (component == 'a' || component == 'alpha') {
        return Chroma.fromRGB(red.toDouble(), green.toDouble(), blue.toDouble(), value);
      }
    } else if (_format == 'hsl') {
      if (component == 'h' || component == 'hue') {
        return Chroma.fromHSL(value, c[1], c[2], c[3]);
      } else if (component == 's' || component == 'saturation') {
        return Chroma.fromHSL(c[0], value, c[2], c[3]);
      } else if (component == 'l' || component == 'lightness') {
        return Chroma.fromHSL(c[0], c[1], value, c[3]);
      } else if (component == 'a' || component == 'alpha') {
        return Chroma.fromHSL(c[0], c[1], c[2], value);
      }
    } else if (_format == 'hsv') {
      if (component == 'h' || component == 'hue') {
        return Chroma.fromHSV(value, c[1], c[2], c[3]);
      } else if (component == 's' || component == 'saturation') {
        return Chroma.fromHSV(c[0], value, c[2], c[3]);
      } else if (component == 'v' || component == 'value') {
        return Chroma.fromHSV(c[0], c[1], value, c[3]);
      } else if (component == 'a' || component == 'alpha') {
        return Chroma.fromHSV(c[0], c[1], c[2], value);
      }
    } else if (_format == 'hwb') {
      if (component == 'h' || component == 'hue') {
        return Chroma.fromHWB(value, c[1], c[2], c[3]);
      } else if (component == 'w' || component == 'whiteness') {
        return Chroma.fromHWB(c[0], value, c[2], c[3]);
      } else if (component == 'b' || component == 'blackness') {
        return Chroma.fromHWB(c[0], c[1], value, c[3]);
      } else if (component == 'a' || component == 'alpha') {
        return Chroma.fromHWB(c[0], c[1], c[2], value);
      }
    } else if (_format == 'xyz') {
      if (component == 'x') {
        return Chroma.fromXYZ(value, c[1], c[2], c[3]);
      } else if (component == 'y') {
        return Chroma.fromXYZ(c[0], value, c[2], c[3]);
      } else if (component == 'z') {
        return Chroma.fromXYZ(c[0], c[1], value, c[3]);
      } else if (component == 'a' || component == 'alpha') {
        return Chroma.fromXYZ(c[0], c[1], c[2], value);
      }
    } else if (_format == 'lab') {
      if (component == 'l' || component == 'lightness') {
        return Chroma.fromLAB(value, c[1], c[2], c[3]);
      } else if (component == 'a') {
        return Chroma.fromLAB(c[0], value, c[2], c[3]);
      } else if (component == 'b') {
        return Chroma.fromLAB(c[0], c[1], value, c[3]);
      } else if (component == 'alpha') {
        return Chroma.fromLAB(c[0], c[1], c[2], value);
      }
    } else if (_format == 'lch') {
      if (component == 'l' || component == 'lightness') {
        return Chroma.fromLCH(value, c[1], c[2], c[3]);
      } else if (component == 'c') {
        return Chroma.fromLCH(c[0], value, c[2], c[3]);
      } else if (component == 'h') {
        return Chroma.fromLCH(c[0], c[1], value, c[3]);
      } else if (component == 'a' || component == 'alpha') {
        return Chroma.fromLCH(c[0], c[1], c[2], value);
      }
    }

    throw ArgumentError.value(component, 'component');
  }

  /// Linearly interpolate between [color1] and [color2] based on the given [ratio].
  ///
  /// You can specify the color space used for interpolation using [mode].
  /// Available modes are: 'linear' and 'rgb'.
  static Chroma lerp(Chroma color1, Chroma color2, [double ratio = 0.5, String mode = 'linear']) {
    ratio = utils.clamp(ratio);

    if (mode == 'linear') {
      final r1 = utils.srgbToLinear(color1.red / 0xFF);
      final r2 = utils.srgbToLinear(color2.red / 0xFF);
      final g1 = utils.srgbToLinear(color1.green / 0xFF);
      final g2 = utils.srgbToLinear(color2.green / 0xFF);
      final b1 = utils.srgbToLinear(color1.blue / 0xFF);
      final b2 = utils.srgbToLinear(color2.blue / 0xFF);
      final a1 = utils.srgbToLinear(color1.opacity);
      final a2 = utils.srgbToLinear(color2.opacity);

      final r = utils.linearToSrgb(r1 * (1 - ratio) + r2 * ratio) * 0xFF;
      final g = utils.linearToSrgb(g1 * (1 - ratio) + g2 * ratio) * 0xFF;
      final b = utils.linearToSrgb(b1 * (1 - ratio) + b2 * ratio) * 0xFF;
      final a = utils.linearToSrgb(a1 * (1 - ratio) + a2 * ratio);

      return Chroma.fromRGB(r, g, b, a);
    } else if (mode == 'rgb') {
      final r = (color1.red    * (1 - ratio) + color2.red * ratio).toDouble();
      final g = (color1.green  * (1 - ratio) + color2.green * ratio).toDouble();
      final b = (color1.blue   * (1 - ratio) + color2.blue * ratio).toDouble();
      final a = color1.opacity * (1 - ratio) + color2.opacity * ratio;

      return Chroma.fromRGB(r, g, b, a);
    } else {
      throw ArgumentError.value(mode, 'mode');
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
    return double.parse(((lighter + 0.05) / (darker + 0.05)).toStringAsFixed(2));
  }

  /// Returns the Euclidean distance between [color1] and [color2].
  ///
  /// Note that this implementation uses the sRGB color space which may not
  /// reflect real differences in human color perception.
  static double difference(Chroma color1, Chroma color2) {
    return math.sqrt(math.pow(color1.red   - color2.red, 2) +
                     math.pow(color1.green - color2.green, 2) +
                     math.pow(color1.blue  - color2.blue, 2));
  }

  /// Returns a color with CSS syntax as a string.
  ///
  /// Specify [format] 'hex' to return a HEX string.
  String toCSS([String format]) {
    if (format == 'hex') {
      // TODO: support short hex output whenever possible
      var hexString = value.toRadixString(16).padLeft(8, '0').substring(2);

      if (alpha != 0xFF) {
        hexString += alpha.toRadixString(16).padLeft(2, '0');
      }

      return '#$hexString';
    } else if (_format == 'rgb') {
      final a = components.elementAt(3);

      return alpha != 0xFF
          ? 'rgba($red, $green, $blue, $a)'
          : 'rgb($red, $green, $blue)';
    } else if (_format == 'hsl' || _format == 'hsv' || _format == 'hwb') {
      final h = utils.checkFractional(components.elementAt(0));
      final x = utils.toPercentage(components.elementAt(1));
      final y = utils.toPercentage(components.elementAt(2));
      final a = components.elementAt(3);

      if (_format == 'hsl') {
        return alpha != 0xFF ? 'hsla($h, $x%, $y%, $a)' : 'hsl($h, $x%, $y%)';
      } else if (_format == 'hsv') {
        return alpha != 0xFF ? 'hsv($h, $x%, $y%, $a)' : 'hsv($h, $x%, $y%)';
      } else if (_format == 'hwb') {
        return alpha != 0xFF ? 'hwb($h, $x%, $y%, $a)' : 'hwb($h, $x%, $y%)';
      }
    }
    
    throw UnsupportedError("CSS doesn't support this color model.");
  }

  @override
  String toString() {
    final hex = toCSS('hex');

    return 'Chroma(\'$hex\')';
  }
}

enum AngleUnit { deg, grad, rad, turn }
