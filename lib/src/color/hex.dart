import 'named_colors.dart';
import '../utils.dart' show bound, toColorValue;

bool _isAsciiHexDigit(int c) =>
    (c >= 97 && c <= 102) || (c >= 65 && c <= 70) || (c >= 48 && c <= 57);

List fromString(String value) {
  assert(value.isNotEmpty);

  value = value.toLowerCase();

  return fromNamed(value) ?? fromHEX(value);
}

List fromHEX(String value) {
  double red, green, blue, alpha;
  final hexString = value.replaceFirst('#', '');

  if ((hexString.length != 3 &&
          hexString.length != 4 &&
          hexString.length != 6 &&
          hexString.length != 8) ||
      !hexString.codeUnits.every(_isAsciiHexDigit)) {
    throw FormatException('Could not parse hex color \'$value\'');
  }

  alpha = 255; // Suppose it's an opaque color. If not we change this below.

  if (hexString.length >= 6) {
    red = int.parse(hexString.substring(0, 2), radix: 16).toDouble();
    green = int.parse(hexString.substring(2, 4), radix: 16).toDouble();
    blue = int.parse(hexString.substring(4, 6), radix: 16).toDouble();
    if (hexString.length == 8) {
      alpha = int.parse(hexString.substring(6, 8), radix: 16).toDouble();
    }
  } else {
    red = int.parse(hexString.substring(0, 1) * 2, radix: 16).toDouble();
    green = int.parse(hexString.substring(1, 2) * 2, radix: 16).toDouble();
    blue = int.parse(hexString.substring(2, 3) * 2, radix: 16).toDouble();
    if (hexString.length == 4) {
      alpha = int.parse(hexString.substring(3, 4) * 2, radix: 16).toDouble();
    }
  }

  alpha = bound(alpha);

  final out = List(2)
    ..[0] = toColorValue(red, green, blue, alpha)
    ..[1] = {
      'r': red,
      'g': green,
      'b': blue,
      'a': alpha,
    };

  return out;
}
