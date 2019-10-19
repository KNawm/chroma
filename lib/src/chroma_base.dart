import 'dart:math';
import 'dart:ui' show Color;

abstract class Chroma {
  Color _currentColor = Color(0xFF000000);

  /// TODO DOCS
  /// <rgb()> | <rgba()> | <hsl()> | <hsla()> |
  /// <hwb()> | <gray()> | <device-cmyk()> |
  /// <hex-color> | <named-color>
  Color chroma(color) {
    String value = color;

    value.toLowerCase();

    if (value.startsWith('#')) {
      value = value.replaceFirst('#', '');
    }

    return Color(int.parse(value, radix: 16));
  }

  /// The rgb() function defines an sRGB color by specifying the red, green,
  /// and blue channels directly. TODO
  Color rgb(r, g, b, [a = 255]) {
    List<dynamic> _rgba = List(4);
    int _r, _g, _b, _a;

    _rgba[0] = r;
    _rgba[1] = g;
    _rgba[2] = b;
    _rgba[3] = a;

    return null;
  }

  Color rgba(r, g, b, a) => rgb(r, g, b, a);

  void _throwEx(value, message) {
    throw ArgumentError.value(value, message);
  }

  /// Returns the alpha channel of a color as an integer between 0 and 255.
  /// A value of 0 is fully transparent, and 255 is fully opaque.
  static int alpha(Color color) => color.alpha;

  /// Returns the alpha channel of a color as a double between 0 and 1.
  /// A value of 0.0 is fully transparent, and 1.0 is fully opaque.
  static double opacity(Color color) => color.opacity;

  /// Returns the red channel of a color as an integer between 0 and 255.
  static int red(Color color) => color.red;

  /// Returns the green channel of a color as an integer between 0 and 255.
  int green(Color color) => color.green;

  /// Returns the blue channel of a color as an integer between 0 and 255.
  int blue(Color color) => color.blue;

  /// Generate a random fully opaque color.
  Color random() {
    const hexMax = 256 * 256 * 256;
    String color = (Random().nextDouble() * hexMax)
        .floor()
        .toRadixString(16)
        .toUpperCase()
        .padLeft(6, '0');
    return Color(0xFF + int.parse(color));
  }

  /*@override
  String toString([colorSpace]) =>
      (colorSpace != null) ? 'rgb($r, $g, $b, $a)' : 'rgb($r, $g, $b, $a)';*/
}
