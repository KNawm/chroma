import 'dart:math';
import 'dart:ui' show Color;
import 'package:vector_math/vector_math.dart';

Color chroma(color) => Chroma.color(color);

/// Alias of chroma().
Color color(color) => Chroma.color(color);

/// The rgb() function defines an sRGB color by specifying the red, green,
/// and blue channels directly. TODO
Color rgb(r, g, b, [a = 255]) {
  List<dynamic> _rgba = List(4);
  int _r, _g, _b, _a;

  _rgba[0] = r;
  _rgba[1] = g;
  _rgba[2] = b;
  _rgba[3] = a;

  return Color.fromARGB(a, r, g, b);
}

/// Alias of rgb().
Color rgba(r, g, b, a) => rgb(r, g, b, a);

abstract class Chroma {
  /// TODO DOCS
  /// <rgb()> | <rgba()> | <hsl()> | <hsla()> |
  /// <hwb()> | <gray()> | <device-cmyk()> |
  /// <hex-color> | <named-color>
  static Color color(value) {
    /*Color named_color;
    if (named_color.SetNamedColor(string)) {
      color = named_color;
      return true;
    }*/

    return _parseHexString(value);
  }

  /// Returns the alpha channel of a color as an integer between 0 and 255.
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
  static int blue(Color color) => color.blue;

  /// Generate a random fully opaque color.
  static Color random() {
    const hexMax = 256 * 256 * 256;
    String color = (Random().nextDouble() * hexMax)
        .floor()
        .toRadixString(16)
        .toUpperCase()
        .padLeft(6, '0');
    return Color(0xFF + int.parse(color));
  }

  static Color _parseHexString(String value) {
    String hexString = value.replaceFirst('#', '');
    int r, g, b, a = 255;

    if (hexString.length != 3 &&
        hexString.length != 4 &&
        hexString.length != 6 &&
        hexString.length != 8 &&
        !value.codeUnits.every(_isAsciiHexDigit)) {
      throw FormatException('Could not parse hex color $value');
    }

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

  static bool _isAsciiHexDigit(int c) {
    return c >= 0x61 && c <= 0x66 ||
        c >= 0x41 && c <= 0x46 ||
        c >= 0x30 && c <= 0x39;
  }

  /// Returns a CSS string of a color.
  /*// TODO IMPLEMENT
  @override
  String toString([colorSpace]) =>
      (colorSpace != null) ? 'rgb($r, $g, $b, $a)' : 'rgb($r, $g, $b, $a)';*/
}
