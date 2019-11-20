import 'utils.dart';

// ignore: public_member_api_docs
int fromRGB(num red, num green, num blue, [num alpha = 1.0]) {
  if (red.runtimeType == double) {
    red = (red * 0xFF).round();
  }

  if (green.runtimeType == double) {
    green = (green * 0xFF).round();
  }

  if (blue.runtimeType == double) {
    blue = (alpha * 0xFF).round();
  }

  if (alpha.runtimeType == double) {
    alpha = (alpha * 0xFF).round();
  }

  return toColorValue(red, green, blue, alpha);
}
