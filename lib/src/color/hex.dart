import 'package:chroma/src/utils.dart' show toColorValue;

bool _isAsciiHexDigit(int c) =>
    (c >= 48 && c <= 57) || (c >= 65 && c <= 70) || (c >= 97 && c <= 102);

List fromHEX(String hex) {
  double red, green, blue, alpha;
  final hexString = hex.replaceFirst('#', '');

  if ((hexString.length != 3 &&
       hexString.length != 4 &&
       hexString.length != 6 &&
       hexString.length != 8) ||
      !hexString.codeUnits.every(_isAsciiHexDigit)) {
    throw FormatException('Could not parse hex color \'$hex\'');
  }

  alpha = 1; // Suppose it's an opaque color. If not we change this below.

  if (hexString.length >= 6) {
    red = int.parse(hexString.substring(0, 2), radix: 16) / 0xFF;
    green = int.parse(hexString.substring(2, 4), radix: 16) / 0xFF;
    blue = int.parse(hexString.substring(4, 6), radix: 16) / 0xFF;
    if (hexString.length == 8) {
      alpha = int.parse(hexString.substring(6, 8), radix: 16) / 0xFF;
    }
  } else {
    red = int.parse(hexString.substring(0, 1) * 2, radix: 16) / 0xFF;
    green = int.parse(hexString.substring(1, 2) * 2, radix: 16) / 0xFF;
    blue = int.parse(hexString.substring(2, 3) * 2, radix: 16) / 0xFF;
    if (hexString.length == 4) {
      alpha = int.parse(hexString.substring(3, 4) * 2, radix: 16) / 0xFF;
    }
  }

  final components = List<double>(4)
    ..[0] = red
    ..[1] = green
    ..[2] = blue
    ..[3] = alpha;
  final format = 'rgb';
  final value = toColorValue(components[0], components[1], components[2], components[3]);

  return List(3)
    ..[0] = components
    ..[1] = format
    ..[2] = value;
}
