import 'package:convert/convert.dart';

// Parameters range is [0, 255]
// ignore: public_member_api_docs
int toColorValue(num red, num green, num blue, num alpha) {
  var r = red.round();
  var g = green.round();
  var b = blue.round();
  var a = alpha.round();

  return (a << 24) | (r << 16) | (g << 8) | (b << 0);
}
