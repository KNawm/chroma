import 'dart:math' as math;
import 'dart:ui' show Color;

import 'package:vector_math/vector_math.dart';

import 'color/parser.dart' as parse;

class Chroma extends Color {
  final List<double> _components = List(4);
  final _colorFormats _colorFormat;

  // ignore: public_member_api_docs
  Chroma(String color)
      : assert(color.isNotEmpty),
        _colorFormat = _colorFormats.HEX,
        super(parse.fromString(color));

  /// The rgb() function defines an sRGB color by specifying the red, green,
  /// blue and alpha channels directly. TODO
  ///
  /// Out of range values are clamped.
  /// Representation of RGBA colors.
  //
  //This structure is used throughout Unity to pass colors around. Each color component is a floating point value with a range from 0 to 1.
  //
  //Components (r,g,b) define a color in RGB color space. Alpha component (a) defines transparency - alpha of one is completely opaque, alpha of zero is completely transparent.
  // ignore: public_member_api_docs
  Chroma.fromRGB(num red, num green, num blue, [num alpha = 1.0])
      : assert(red.runtimeType == double
            ? (red >= 0.0 && red <= 1.0)
            : (red >= 0 && red <= 255)),
        assert(green.runtimeType == double
            ? (green >= 0.0 && green <= 1.0)
            : (green >= 0 && green <= 255)),
        assert(blue.runtimeType == double
            ? (blue >= 0.0 && blue <= 1.0)
            : (blue >= 0 && blue <= 255)),
        assert(alpha.runtimeType == double
            ? (alpha >= 0.0 && alpha <= 1.0)
            : (alpha >= 0 && alpha <= 255)),
        _colorFormat = _colorFormats.RGB,
        super(parse.fromRGB(red, green, blue, alpha));

  // ignore: public_member_api_docs
  Chroma.fromHSL(double hue, double saturation, double lightness,
      [double alpha = 1.0, AngleUnits angleUnit = AngleUnits.deg])
      : assert(saturation >= 0.0),
        assert(saturation <= 1.0),
        assert(lightness >= 0.0),
        assert(lightness <= 1.0),
        assert(alpha >= 0.0),
        assert(alpha <= 1.0),
        _colorFormat = _colorFormats.HSL,
        super(parse.fromHSL(hue, saturation, lightness, alpha, angleUnit));

  // ignore: public_member_api_docs
  Chroma.fromHSV(double hue, double saturation, double value,
      [double alpha = 1.0, AngleUnits angleUnit = AngleUnits.deg])
      : assert(saturation >= 0.0),
        assert(saturation <= 1.0),
        assert(value >= 0.0),
        assert(value <= 1.0),
        assert(alpha >= 0.0),
        assert(alpha <= 1.0),
        _colorFormat = _colorFormats.HSV,
        super(parse.fromHSV(hue, saturation, value, alpha, angleUnit));

  // ignore: public_member_api_docs
  Chroma.fromHWB(double hue, double whiteness, double blackness,
      [double alpha = 1.0, AngleUnits angleUnit = AngleUnits.deg])
      : assert(whiteness >= 0.0),
        assert(whiteness <= 1.0),
        assert(blackness >= 0.0),
        assert(blackness <= 1.0),
        assert(alpha >= 0.0),
        assert(alpha <= 1.0),
        _colorFormat = _colorFormats.HWB,
        super(parse.fromHWB(hue, whiteness, blackness, alpha, angleUnit));

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

  /// Generate a random fully opaque color.
  static Color random() {
    const hexMax = 256 * 256 * 256;
    final color = (math.Random().nextDouble() * hexMax).floor();
    return Color(color + 0xFF000000);
  }

  static Color contrastColor(Color color) {
    final r = color.red;
    final g = color.green;
    final b = color.blue;

    // See <https://www.w3.org/TR/AERT/#color-contrast>
    return ((r * 299) + (g * 587) + (b * 114)) / 1000 > 125 ? _black : _white;
  }

  static Color toGrayscale(Color color) {
    // TODO: research how to do this with Lab

    // See <https://en.wikipedia.org/wiki/Luma_(video)>
    final value = 0.2126 * (color.red / 0xFF) +
        0.7152 * (color.green / 0xFF) +
        0.0722 * (color.blue / 0xFF);

    /*final value = 0.299 * (color.red / 0xFF) +
        0.587 * (color.green / 0xFF) +
        0.114 * (color.blue / 0xFF);*/

    return Chroma.fromRGB(value, value, value, color.alpha)
  }

  @override
  String toString() {
    switch (_colorFormat) {
      case _colorFormats.HEX:
        // TODO: support short hex output whenever possible
        var hexString = red.toRadixString(16).padLeft(2, '0') +
            green.toRadixString(16).padLeft(2, '0') +
            blue.toRadixString(16).padLeft(2, '0');

        if (alpha != 0xFF) {
          hexString += alpha.toRadixString(16).padLeft(2, '0');
        }

        return '#$hexString';
      case _colorFormats.RGB:
        return '$runtimeType($alpha, $alpha, $alpha, $value)';
      case _colorFormats.HSL:
        return 'Color(0x${value.toRadixString(16).padLeft(8, '0')})';
      case _colorFormats.HSV:
        return 'Color(0x${value.toRadixString(16).padLeft(8, '0')})';
      case _colorFormats.HWB:
        return 'Color(0x${value.toRadixString(16).padLeft(8, '0')})';
      default:
        return 'If you\'re seeing this, open an issue.';
    }
  }
}

enum AngleUnits { deg, grad, rad, turn }

// TODO: support LCH, LAB, HCL, CMYK.
enum _colorFormats { HEX, RGB, HSL, HSV, HWB }
