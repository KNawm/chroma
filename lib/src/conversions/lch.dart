import 'dart:math' as math show cos, sin, pi;

List<double> lchToLab(double l, double c, double h) {
  h = h * math.pi / 180;
  final L = l;
  final A = c * math.cos(h);
  final B = c * math.sin(h);

  return List(3)
    ..[0] = L
    ..[1] = A
    ..[2] = B;
}
