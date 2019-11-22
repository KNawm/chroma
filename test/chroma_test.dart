import 'dart:math';
import 'dart:ui' show Color;

import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';

import 'package:chroma/chroma.dart';

void main() {
  // #f0f      / fromRGB(255, 0, 255)          / fromHSL(300, 100%, 50%)
  final colorFuchsia = Color(0xFFFF00FF).hashCode;
  // #baaaaaaa / fromRGB(186, 170, 170, 0.666) / fromHSL(0, 10.4%, 69.8%, 0.666)
  final colorSheep = Color(0xAABAAAAA).hashCode;
  // #feedbacc / fromRGB(254, 237, 186, 0.8)   / fromHSL(45, 97.1%, 86.3%, 0.8)
  final colorFeedback = Color(0xCCFEEDBA).hashCode;

  group('Syntax parsing', () {
    test('Named colors', () {
      expect(Chroma('fuchsia').hashCode, colorFuchsia);
      expect(Chroma('FUCHSIA').hashCode, colorFuchsia);

      expect(() => Chroma('fuchsias'), throwsFormatException);
    });

    test('Hash syntax', () {
      expect(Chroma('#FF00FF').hashCode, colorFuchsia);
      expect(Chroma('#F0F').hashCode, colorFuchsia);
      expect(Chroma('#FF00FFFF').hashCode, colorFuchsia);
      expect(Chroma('#F0FF').hashCode, colorFuchsia);

      expect(Chroma('#ff00ff').hashCode, colorFuchsia);
      expect(Chroma('#f0f').hashCode, colorFuchsia);
      expect(Chroma('#ff00ffff').hashCode, colorFuchsia);
      expect(Chroma('#f0ff').hashCode, colorFuchsia);

      expect(Chroma('FF00FF').hashCode, colorFuchsia);
      expect(Chroma('F0F').hashCode, colorFuchsia);
      expect(Chroma('FF00FFFF').hashCode, colorFuchsia);
      expect(Chroma('F0FF').hashCode, colorFuchsia);

      expect(Chroma('ff00ff').hashCode, colorFuchsia);
      expect(Chroma('f0f').hashCode, colorFuchsia);
      expect(Chroma('ff00ffff').hashCode, colorFuchsia);
      expect(Chroma('f0ff').hashCode, colorFuchsia);

      expect(() => Chroma('asd'), throwsFormatException);
      expect(() => Chroma('#baaaaaaa '), throwsFormatException);
      expect(() => Chroma(' #feedbacc'), throwsFormatException);
    });

    test('RGB syntax', () {
      expect(Chroma.fromRGB(255, 0, 255).hashCode, colorFuchsia);
      expect(Chroma.fromRGB(1.0, 0, 1.0).hashCode, colorFuchsia);
      expect(Chroma.fromRGB(255, 0, 1.0).hashCode, colorFuchsia);

      expect(Chroma.fromRGB(186, 170, 170, 0.666).hashCode, colorSheep);
      expect(Chroma.fromRGB(186, 0.666, 0.666, 0.666).hashCode, colorSheep);
      expect(Chroma.fromRGB((186 / 255), 170, 170, 170).hashCode, colorSheep);

      expect(Chroma.fromRGB(254, 237, 186, 0.8).hashCode, colorFeedback);
      expect(Chroma.fromRGB(254, 237, 186, 204).hashCode, colorFeedback);

      //todo write tests with out of range values and examples with scientific notation
    });

    test('HSL syntax', () {
      expect(Chroma.fromHSL(-60, 1.0, 0.5).hashCode, colorFuchsia);
      expect(Chroma.fromHSL(300, 1.0, 0.5).hashCode, colorFuchsia);
      expect(Chroma.fromHSL(660, 1.0, 0.5).hashCode, colorFuchsia);
      expect(
          Chroma.fromHSL(300 * 200 / 180, 1, .5, 1, AngleUnits.grad).hashCode,
          colorFuchsia);
      expect(Chroma.fromHSL(300 * pi / 180, 1, .5, 1, AngleUnits.rad).hashCode,
          colorFuchsia);
      expect(Chroma.fromHSL(300 / 360, 1.0, .5, 1, AngleUnits.turn).hashCode,
          colorFuchsia);

      expect(Chroma.fromHSL(0, 0.104, 0.698, 0.666).hashCode, colorSheep);

      expect(Chroma.fromHSL(45, 0.971, 0.863, 0.8).hashCode, colorFeedback);

      //todo write tests with out of range values and examples with scientific notation
    });

    test('HSV syntax', () {
      expect(Chroma.fromHSV(300, 1.0, 1.0).hashCode, colorFuchsia);
      expect(Chroma.fromHSV(660, 1.0, 1.0).hashCode, colorFuchsia);
      expect(Chroma.fromHSV(300 * 200 / 180, 1, 1, 1, AngleUnits.grad).hashCode,
          colorFuchsia);
      expect(Chroma.fromHSV(300 * pi / 180, 1, 1, 1, AngleUnits.rad).hashCode,
          colorFuchsia);
      expect(Chroma.fromHSV(300 / 360, 1.0, 1, 1, AngleUnits.turn).hashCode,
          colorFuchsia);

      expect(Chroma.fromHSV(0, 0.086, 0.729, 0.666).hashCode, colorSheep);

      expect(Chroma.fromHSV(45, 0.268, 0.996, 0.8).hashCode, colorFeedback);

      //todo write tests with out of range values and examples with scientific notation
    });

    test('HWB syntax', () {
      expect(Chroma.fromHWB(300, 0, 0, 1.0).hashCode, colorFuchsia);
      expect(Chroma.fromHWB(660, 0, 0, 1.0).hashCode, colorFuchsia);
      expect(Chroma.fromHWB(300 * 200 / 180, 0, 0, 1, AngleUnits.grad).hashCode,
          colorFuchsia);
      expect(Chroma.fromHWB(300 * pi / 180, 0, 0, 1, AngleUnits.rad).hashCode,
          colorFuchsia);
      expect(Chroma.fromHWB(300 / 360, 0, 0, 1, AngleUnits.turn).hashCode,
          colorFuchsia);

      expect(Chroma.fromHWB(0, 0.665, 0.27, 0.666).hashCode, colorSheep);

      expect(Chroma.fromHWB(45, 0.729, 0.004, 0.8).hashCode, colorFeedback);

      //todo write tests with out of range values and examples with scientific notation
    });
  });

  group('Color base', () {
    final colorHEX = Chroma('fuchsia');
    final colorRGB = Chroma.fromRGB(255, 0, 255);
    final colorHSL = Chroma.fromHSL(300, 1, .5);
    final colorHSV = Chroma.fromHSV(300, 1, 1);
    final colorHWB = Chroma.fromHWB(300, 0, 0);

    test('Components', () {
      expect(colorHEX.components, {'r': 1, 'g': 0, 'b': 1, 'a': 1});
      expect(colorRGB.components, {'r': 1, 'g': 0, 'b': 1, 'a': 1});
      expect(colorHSL.components, {'h': 300, 's': 1, 'l': .5, 'a': 1});
      expect(colorHSV.components, {'h': 300, 's': 1, 'v': 1, 'a': 1});
      expect(colorHWB.components, {'h': 300, 'w': 0, 'b': 0, 'a': 1});

      expect(colorHEX.toString(), '#ff00ff');
      expect(colorRGB.toString(), 'rgb(255, 0, 255)');
      expect(colorHSL.toString(), 'hsl(300, 100%, 50%)');
      expect(colorHSV.toString(), 'hsv(300, 100%, 100%)');
      expect(colorHWB.toString(), 'hwb(300, 0%, 0%)');
    });
  });
}
