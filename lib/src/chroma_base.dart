import 'dart:math';
import 'dart:ui' show Color;

import 'package:flutter/painting.dart';

part 'named_colors.dart';

Color chroma(color) => Chroma.color(color);
Color rgb(r, g, b, [a = 255]) => Chroma.rgb(r, g, b, a);

class Chroma {
  Chroma._();

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

  /// TODO DOCS
  /// <rgb()> | <rgba()> | <hsl()> | <hsla()> |
  /// <hwb()> | <gray()> | <device-cmyk()> |
  /// <hex-color> | <named-color>
  static Color color(value) {
    if (_isNamedColor(value)) {
      return _namedColors.values
          .firstWhere((name) => _namedColors[name] == value);
    }

    return _parseHexString(value);
  }

  /// The rgb() function defines an sRGB color by specifying the red, green,
  /// and blue channels directly. TODO
  static Color rgb(r, g, b, [a = 255]) {
    return Color.fromARGB(a, r, g, b);
  }

  /// Alias of rgb().
  static Color rgba(r, g, b, a) => rgb(r, g, b, a);

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

    if ((hexString.length != 3 &&
            hexString.length != 4 &&
            hexString.length != 6 &&
            hexString.length != 8) ||
        !hexString.codeUnits.every(_isAsciiHexDigit)) {
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

  static bool _isAsciiHexDigit(int c) =>
      (c >= 97 && c <= 102) || (c >= 65 && c <= 70) || (c >= 48 && c <= 57);

  static bool _isNamedColor(String value) => _namedColors.containsKey(value);

  /// Returns a CSS string of a color.
  /*// TODO IMPLEMENT
  @override
  String toString([colorSpace]) =>
      (colorSpace != null) ? 'rgb($r, $g, $b, $a)' : 'rgb($r, $g, $b, $a)';*/
}
