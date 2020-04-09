part of 'ops.dart';

Chroma blendLRGB(Chroma color1, Chroma color2, double ratio) {
  final r = sqrt(pow(color1.red,   2) * (1 - ratio) + pow(color2.red,   2) * ratio);
  final g = sqrt(pow(color1.green, 2) * (1 - ratio) + pow(color2.green, 2) * ratio);
  final b = sqrt(pow(color1.blue,  2) * (1 - ratio) + pow(color2.blue,  2) * ratio);
  final a = sqrt(pow(color1.alpha, 2) * (1 - ratio) + pow(color2.alpha, 2) * ratio);
  return Chroma.fromRGB(r, g, b, a);
}

Chroma blendRGB(Chroma color1, Chroma color2, double ratio) {
  final r = color1.red   * (1 - ratio) + color2.red   * ratio;
  final g = color1.green * (1 - ratio) + color2.green * ratio;
  final b = color1.blue  * (1 - ratio) + color2.blue  * ratio;
  final a = color1.alpha * (1 - ratio) + color2.alpha * ratio;
  return Chroma.fromRGB(r, g, b, a);
}

