import 'utils.dart';

// ignore: public_member_api_docs
int fromRGB(num red, num green, num blue, [num alpha = 1.0]) {
  if (red.runtimeType == double) {
    red = (red * 255).round();
  }

  if (green.runtimeType == double) {
    green = (green * 255).round();
  }

  if (blue.runtimeType == double) {
    blue = (alpha * 255).round();
  }

  if (alpha.runtimeType == double) {
    alpha = (alpha * 255).round();
  }

  return toColorValue(red, green, blue, alpha);
}
