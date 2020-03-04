import 'dart:math' as math show pow;

import 'package:flutter_test/flutter_test.dart';

import 'package:chroma/src/chroma_base.dart' show AngleUnits;
import 'package:chroma/src/color/utils.dart';

void main() {
  group('Functions', () {
    test('bound()', () {
      final minRGB = 0x00;
      final maxRGB = 0xFF;

      expect(bound(minRGB), equals(0.0));
      expect(bound(maxRGB), equals(1.0));
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

      expect(convertToDegrees(0, AngleUnits.deg), equals(circle));
      expect(convertToDegrees(0, AngleUnits.grad), equals(circle));
      expect(convertToDegrees(0, AngleUnits.rad), equals(circle));
      expect(convertToDegrees(0, AngleUnits.turn), equals(circle));

      expect(convertToDegrees(180, AngleUnits.deg), equals(half));
      expect(convertToDegrees(200, AngleUnits.grad), equals(half));
      expect(convertToDegrees(3.14159, AngleUnits.rad), closeTo(half, 0.005));
      expect(convertToDegrees(0.5, AngleUnits.turn), equals(half));

      expect(convertToDegrees(90, AngleUnits.deg), equals(quarter));
      expect(convertToDegrees(100, AngleUnits.grad), equals(quarter));
      expect(convertToDegrees(1.5708, AngleUnits.rad), closeTo(quarter, 0.005));
      expect(convertToDegrees(0.25, AngleUnits.turn), equals(quarter));
    });
  });
}
