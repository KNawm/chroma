import 'dart:math' as math show pow;

import 'package:chroma/src/chroma_base.dart' show AngleUnit;
import 'package:chroma/src/utils.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Functions', () {
    test('bound()', () {
      final minRGB = 0x00;
      final maxRGB = 0xFF;

      expect(bound(minRGB.toDouble()), equals(0.0));
      expect(bound(maxRGB.toDouble()), equals(1.0));
      expect(bound(maxRGB / 2), equals(0.5));
    });

    test('checkFractional()', () {
      final min = 0.0, max = 1.0;
      final notTruncated = 1.23;

      expect(min, isA<double>());
      expect(checkFractional(min), isA<int>());
      expect(max, isA<double>());
      expect(checkFractional(max), isA<int>());
      expect(notTruncated, isA<double>());
      expect(checkFractional(notTruncated), isA<double>());
    });

    test('toPercentage()', () {
      final min = 0.0, max = 1.0;

      expect(toPercentage(min), equals(0));
      expect(toPercentage(max), equals(100));
      expect(toPercentage(max / 2), equals(50));
      expect(toPercentage(max / 7), closeTo(14.285, 0.005));
    });

    test('toColorValue()', () {
      final max = math.pow(16, 8) - 1;

      expect(toColorValue(255, 255, 255, 1), equals(max));
      expect(toColorValue(128, 128, 128, 0.5).toRadixString(16), '80808080');
    });

    test('convertToDegrees()', () {
      final circle = 0;
      final half = 180;
      final quarter = 90;

      expect(convertToDegrees(0, AngleUnit.deg), equals(circle));
      expect(convertToDegrees(0, AngleUnit.grad), equals(circle));
      expect(convertToDegrees(0, AngleUnit.rad), equals(circle));
      expect(convertToDegrees(0, AngleUnit.turn), equals(circle));

      expect(convertToDegrees(180, AngleUnit.deg), equals(half));
      expect(convertToDegrees(200, AngleUnit.grad), equals(half));
      expect(convertToDegrees(3.14159, AngleUnit.rad), closeTo(half, 0.005));
      expect(convertToDegrees(0.5, AngleUnit.turn), equals(half));

      expect(convertToDegrees(90, AngleUnit.deg), equals(quarter));
      expect(convertToDegrees(100, AngleUnit.grad), equals(quarter));
      expect(convertToDegrees(1.5708, AngleUnit.rad), closeTo(quarter, 0.005));
      expect(convertToDegrees(0.25, AngleUnit.turn), equals(quarter));
    });
  });
}
