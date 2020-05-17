import 'dart:math' as math show pow;

import 'package:chroma/src/chroma_base.dart' show AngleUnit;
import 'package:chroma/src/utils.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Functions', () {
    test('clamp()', () {
      final min = 0.0, max = 1.0;

      expect(clamp(min - 1), equals(0.0));
      expect(clamp(max / 2), equals(0.5));
      expect(clamp(max + 1), equals(1.0));
    });

    test('clamp8()', () {
      final min = 0x00, max = 0xFF;

      expect(clamp8((min - 1).toDouble()), equals(0));
      expect(clamp8((max / 2).toDouble()), equals(127.5));
      expect(clamp8((max + 1).toDouble()), equals(255));
    });

    test('bound()', () {
      final min = 0x00, max = 0xFF;

      expect(bound(min.toDouble()), equals(0.0));
      expect(bound(max.toDouble()), equals(1.0));
      expect(bound(max / 2), equals(0.5));
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

    test('srgbToLinear()', () {
      expect(srgbToLinear(0   / 0xFF), equals(0));
      expect(srgbToLinear(128 / 0xFF), equals(0.21586050011389926));
      expect(srgbToLinear(187 / 0xFF), equals(0.4969329950608704));
      expect(srgbToLinear(255 / 0xFF), equals(1));
    });

    test('linearToSrgb()', () {
      // Round-trips with srgbToLinear()
      expect((linearToSrgb((srgbToLinear(0   / 0xFF))) * 0xFF).round(), equals(0));
      expect((linearToSrgb((srgbToLinear(128 / 0xFF))) * 0xFF).round(), equals(128));
      expect((linearToSrgb((srgbToLinear(187 / 0xFF))) * 0xFF).round(), equals(187));
      expect((linearToSrgb((srgbToLinear(255 / 0xFF))) * 0xFF).round(), equals(255));
    });

    test('convertToDegrees()', () {
      final circle = 0, quarter = 90, half = 180;

      expect(convertToDegrees(0, AngleUnit.deg) , equals(circle));
      expect(convertToDegrees(0, AngleUnit.grad), equals(circle));
      expect(convertToDegrees(0, AngleUnit.rad) , equals(circle));
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
