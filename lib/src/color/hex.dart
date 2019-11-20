import 'utils.dart';

bool _isAsciiHexDigit(int c) =>
    (c >= 97 && c <= 102) || (c >= 65 && c <= 70) || (c >= 48 && c <= 57);

// ignore: public_member_api_docs
int fromHEX(String value) {
  int red, green, blue, alpha;
  var hexString = value.replaceFirst('#', '');

  if ((hexString.length != 3 &&
          hexString.length != 4 &&
          hexString.length != 6 &&
          hexString.length != 8) ||
      !hexString.codeUnits.every(_isAsciiHexDigit)) {
    throw FormatException('Could not parse hex color \'$value\'');
  }

  alpha = 255; // Suppose it's an opaque color. If not we change this below.

  if (hexString.length >= 6) {
    red = int.parse(hexString.substring(0, 2), radix: 16);
    green = int.parse(hexString.substring(2, 4), radix: 16);
    blue = int.parse(hexString.substring(4, 6), radix: 16);
    if (hexString.length == 8) {
      alpha = int.parse(hexString.substring(6, 8), radix: 16);
    }
  } else {
    red = int.parse(hexString.substring(0, 1) * 2, radix: 16);
    green = int.parse(hexString.substring(1, 2) * 2, radix: 16);
    blue = int.parse(hexString.substring(2, 3) * 2, radix: 16);
    if (hexString.length == 4) {
      alpha = int.parse(hexString.substring(3, 4) * 2, radix: 16);
    }
  }

  return toColorValue(red, green, blue, alpha);
}
