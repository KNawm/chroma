import 'dart:math' as math show pow, Random, sqrt;
import 'dart:ui' show Color;

import 'package:flutter/rendering.dart';

import 'color/parser.dart' as parse;
import 'utils.dart' as utils;

class Chroma extends Color {
  final _ColorFormat _format;
  final Map<String, double> _components;

  Chroma._(List color, _ColorFormat format)
      : _format = format,
        _components = color[1],
        super(color[0]);

  /// Creates a color by specifying a 3, 4, 6 and 8-digit hexadecimal string or
  /// you can use any of the 148 named CSS colors by specifying its color keyword.
  factory Chroma(String value) {
    return Chroma._(parse.fromString(value), _ColorFormat.rgb);
  }

  /// Creates a color by specifying [red], [green], [blue] and [alpha] as components.
  ///
  /// All components, except for the [alpha], are doubles between 0 and 255.
  /// The [alpha] is a double between 0.0 and 1.0.
  ///
  /// An [alpha] value of 1.0 is completely opaque, and 0.0 is completely transparent.
  factory Chroma.fromRGB(double red, double green, double blue,
          [double alpha = 1.0]) =>
      Chroma._(parse.fromRGB(red, green, blue, alpha), _ColorFormat.rgb);

  /// Creates a color by specifying [hue], [saturation], [lightness] and [alpha] as components.
  ///
  /// All components, except for the [hue], are doubles between 0.0 and 1.0.
  /// The [hue] is a double without range as you can specify the angular unit of
  /// your preference using [angleUnit].
  ///
  /// An [alpha] value of 1.0 is completely opaque, and 0.0 is completely transparent.
  factory Chroma.fromHSL(double hue, double saturation, double lightness,
          [double alpha = 1.0, AngleUnit angleUnit = AngleUnit.deg]) =>
      Chroma._(parse.fromHSL(hue, saturation, lightness, alpha, angleUnit),
          _ColorFormat.hsl);

  /// Creates a color by specifying [hue], [saturation], [value] and [alpha] as components.
  ///
  /// All components, except for the [hue], are doubles between 0.0 and 1.0.
  /// The [hue] is a double without range as you can specify the angular unit of
  /// your preference using [angleUnit].
  ///
  /// An [alpha] value of 1.0 is completely opaque, and 0.0 is completely transparent.
  factory Chroma.fromHSV(double hue, double saturation, double value,
          [double alpha = 1.0, AngleUnit angleUnit = AngleUnit.deg]) =>
      Chroma._(parse.fromHSV(hue, saturation, value, alpha, angleUnit),
          _ColorFormat.hsv);

  /// Creates a color by specifying [hue], [whiteness], [blackness] and [alpha] as components.
  ///
  /// All components, except for the [hue], are doubles between 0.0 and 1.0.
  /// The [hue] is a double without range as you can specify the angular unit of
  /// your preference using [angleUnit].
  ///
  /// An [alpha] value of 1.0 is completely opaque, and 0.0 is completely transparent.
  factory Chroma.fromHWB(double hue, double whiteness, double blackness,
          [double alpha = 1.0, AngleUnit angleUnit = AngleUnit.deg]) =>
      Chroma._(parse.fromHWB(hue, whiteness, blackness, alpha, angleUnit),
          _ColorFormat.hwb);

  /// Returns the values of the 4 components of the color, which components are
  /// present depends on the color model.
  ///
  /// All values, except for the hue, are doubles between 0.0 and 1.0.
  /// The hue is a double between 0.0 and 360.0.
  Map<String, double> get components => _components;

  @override
  double get opacity => components.values.elementAt(3);

  /// Returns the format of the color.
  String get format {
    if (_format == _ColorFormat.rgb) {
      return 'rgb';
    } else if (_format == _ColorFormat.hsl) {
      return 'hsl';
    } else if (_format == _ColorFormat.hsv) {
      return 'hsv';
    } else if (_format == _ColorFormat.hwb) {
      return 'hwb';
    }
  }

  Chroma grayscale() {
    // See <https://en.wikipedia.org/wiki/Grayscale>
    final linear = 0.2126 * (utils.srgbToLinear(red   / 0xFF)) +
                   0.7152 * (utils.srgbToLinear(green / 0xFF)) +
                   0.0722 * (utils.srgbToLinear(blue  / 0xFF));

    // Gamma compression
    var srgb = (utils.linearToSrgb(linear) * 0xFF).roundToDouble();

    // TODO: maybe don't implicitly change the color model
    return Chroma.fromRGB(srgb, srgb, srgb, opacity);
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

  /// Returns a new color that matches this color with the component replaced
  /// with the given value.
  ///
  /// All values, except for the hue, are doubles between 0.0 and 1.0.
  /// The hue is a double between 0.0 and 360.0.
  Chroma withValue(String component, double value) {
    final c = List.from(components.values);
    component = component.toLowerCase();

    if (_format == _ColorFormat.rgb) {
      if (component == 'r' || component == 'red') {
        return Chroma.fromRGB(value * 0xFF, c[1], c[2], c[3]);
      } else if (component == 'g' || component == 'green') {
        return Chroma.fromRGB(c[0], value * 0xFF, c[2], c[3]);
      } else if (component == 'b' || component == 'blue') {
        return Chroma.fromRGB(c[0], c[1], value * 0xFF, c[3]);
      } else if (component == 'a' || component == 'alpha') {
        return Chroma.fromRGB(c[0], c[1], c[2], value);
      }
    } else if (_format == _ColorFormat.hsl) {
      if (component == 'h' || component == 'hue') {
        return Chroma.fromHSL(value, c[1], c[2], c[3]);
      } else if (component == 's' || component == 'saturation') {
        return Chroma.fromHSL(c[0], value, c[2], c[3]);
      } else if (component == 'l' || component == 'lightness') {
        return Chroma.fromHSL(c[0], c[1], value, c[3]);
      } else if (component == 'a' || component == 'alpha') {
        return Chroma.fromHSL(c[0], c[1], c[2], value);
      }
    } else if (_format == _ColorFormat.hsv) {
      if (component == 'h' || component == 'hue') {
        return Chroma.fromHSV(value, c[1], c[2], c[3]);
      } else if (component == 's' || component == 'saturation') {
        return Chroma.fromHSV(c[0], value, c[2], c[3]);
      } else if (component == 'v' || component == 'value') {
        return Chroma.fromHSV(c[0], c[1], value, c[3]);
      } else if (component == 'a' || component == 'alpha') {
        return Chroma.fromHSV(c[0], c[1], c[2], value);
      }
    } else if (_format == _ColorFormat.hwb) {
      if (component == 'h' || component == 'hue') {
        return Chroma.fromHWB(value, c[1], c[2], c[3]);
      } else if (component == 'w' || component == 'whiteness') {
        return Chroma.fromHWB(c[0], value, c[2], c[3]);
      } else if (component == 'b' || component == 'blackness') {
        return Chroma.fromHWB(c[0], c[1], value, c[3]);
      } else if (component == 'a' || component == 'alpha') {
        return Chroma.fromHWB(c[0], c[1], c[2], value);
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
      final r = (color1.red    * (1 - ratio) + color2.red * ratio).roundToDouble();
      final g = (color1.green  * (1 - ratio) + color2.green * ratio).roundToDouble();
      final b = (color1.blue   * (1 - ratio) + color2.blue * ratio).roundToDouble();
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
  String toCssString({String format}) {
    if (format == 'hex') {
      // TODO: support short hex output whenever possible
      var hexString = value.toRadixString(16).padLeft(8, '0').substring(2);

      if (alpha != 0xFF) {
        hexString += alpha.toRadixString(16).padLeft(2, '0');
      }

      return '#$hexString';
    } else if (_format == _ColorFormat.rgb) {
      final a = components.values.elementAt(3);

      return alpha != 0xFF
          ? 'rgba($red, $green, $blue, $a)'
          : 'rgb($red, $green, $blue)';
    } else {
      final h = utils.checkFractional(components.values.elementAt(0));
      final x = utils.toPercentage(components.values.elementAt(1));
      final y = utils.toPercentage(components.values.elementAt(2));
      final a = components.values.elementAt(3);

      if (_format == _ColorFormat.hsl) {
        return alpha != 0xFF ? 'hsla($h, $x%, $y%, $a)' : 'hsl($h, $x%, $y%)';
      } else if (_format == _ColorFormat.hsv) {
        return alpha != 0xFF ? 'hsv($h, $x%, $y%, $a)' : 'hsv($h, $x%, $y%)';
      } else if (_format == _ColorFormat.hwb) {
        return alpha != 0xFF ? 'hwb($h, $x%, $y%, $a)' : 'hwb($h, $x%, $y%)';
      }
    }
  }

  @override
  String toString() {
    final hex = toCssString(format: 'hex');

    return 'Chroma(\'$hex\')';
  }
}

enum _ColorFormat { rgb, hsl, hsv, hwb }
enum AngleUnit { deg, grad, rad, turn }
