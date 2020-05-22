import 'dart:math';
import 'dart:ui' show Color;

import 'package:chroma/chroma.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  // #f0f      / rgb(255, 0, 255)          / hsl(300, 100%, 50%)
  final colorFuchsia = Color(0xFFFF00FF).hashCode;
  // #baaaaaaa / rgb(186, 170, 170, 0.666) / hsl(0, 10.4%, 69.8%, 0.666)
  final colorSheep = Color(0xAABAAAAA).hashCode;
  // #feedbacc / rgb(254, 237, 186, 0.8)   / hsl(45, 97.1%, 86.3%, 0.8)
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
      expect(Chroma.fromRGB(186, 170, 170, 0.666).hashCode, colorSheep);
      expect(Chroma.fromRGB(254, 237, 186, 0.8).hashCode, colorFeedback);

      // TODO: Tests with out of range values and examples with scientific notation.
    });

    test('HSL syntax', () {
      expect(Chroma.fromHSL(-60, 1.0, 0.5).hashCode, colorFuchsia);
      expect(Chroma.fromHSL(300, 1.0, 0.5).hashCode, colorFuchsia);
      expect(Chroma.fromHSL(660, 1.0, 0.5).hashCode, colorFuchsia);
      expect(
          Chroma.fromHSL(300 * 200 / 180, 1, .5, 1, AngleUnit.grad).hashCode,
          colorFuchsia);
      expect(Chroma.fromHSL(300 * pi / 180, 1, .5, 1, AngleUnit.rad).hashCode,
          colorFuchsia);
      expect(Chroma.fromHSL(300 / 360, 1.0, .5, 1, AngleUnit.turn).hashCode,
          colorFuchsia);

      expect(Chroma.fromHSL(0, 0.104, 0.698, 0.666).hashCode, colorSheep);

      expect(Chroma.fromHSL(45, 0.971, 0.863, 0.8).hashCode, colorFeedback);

      // TODO: Tests with out of range values and examples with scientific notation.
    });

    test('HSV syntax', () {
      expect(Chroma.fromHSV(300, 1.0, 1.0).hashCode, colorFuchsia);
      expect(Chroma.fromHSV(660, 1.0, 1.0).hashCode, colorFuchsia);
      expect(Chroma.fromHSV(300 * 200 / 180, 1, 1, 1, AngleUnit.grad).hashCode,
          colorFuchsia);
      expect(Chroma.fromHSV(300 * pi / 180, 1, 1, 1, AngleUnit.rad).hashCode,
          colorFuchsia);
      expect(Chroma.fromHSV(300 / 360, 1.0, 1, 1, AngleUnit.turn).hashCode,
          colorFuchsia);

      expect(Chroma.fromHSV(0, 0.086, 0.729, 0.666).hashCode, colorSheep);

      expect(Chroma.fromHSV(45, 0.268, 0.996, 0.8).hashCode, colorFeedback);

      // TODO: Tests with out of range values and examples with scientific notation.
    });

    test('HWB syntax', () {
      expect(Chroma.fromHWB(300, 0, 0, 1.0).hashCode, colorFuchsia);
      expect(Chroma.fromHWB(660, 0, 0, 1.0).hashCode, colorFuchsia);
      expect(Chroma.fromHWB(300 * 200 / 180, 0, 0, 1, AngleUnit.grad).hashCode,
          colorFuchsia);
      expect(Chroma.fromHWB(300 * pi / 180, 0, 0, 1, AngleUnit.rad).hashCode,
          colorFuchsia);
      expect(Chroma.fromHWB(300 / 360, 0, 0, 1, AngleUnit.turn).hashCode,
          colorFuchsia);
      expect(Chroma.fromHWB(0, 0.665, 0.27, 0.666).hashCode, colorSheep);
      expect(Chroma.fromHWB(45, 0.729, 0.004, 0.8).hashCode, colorFeedback);
      expect(Chroma.fromHWB(0, .8, .8).hashCode, Color(0xFF808080).hashCode);

      // TODO: Tests with out of range values and examples with scientific notation.
    });
  });

  group('Colors', () {
    final colorHEX = Chroma('fuchsia');
    final colorRGB = Chroma.fromRGB(255, 0, 255);
    final colorHSL = Chroma.fromHSL(300, 1, .5);
    final colorHSV = Chroma.fromHSV(300, 1, 1);
    final colorHWB = Chroma.fromHWB(300, 0, 0);

    test('Format', () {
      expect(colorHEX.format, equals('rgb'));
      expect(colorRGB.format, equals('rgb'));
      expect(colorHSL.format, equals('hsl'));
      expect(colorHSV.format, equals('hsv'));
      expect(colorHWB.format, equals('hwb'));
    });

    test('withComponent functions', () {
      expect(colorHEX.withRed(0), equals(Chroma('blue')));
      expect(colorRGB.withGreen(255), equals(Chroma('white')));
      expect(colorHSL.withBlue(0), equals(Chroma('red')));
      expect(colorHSV.withAlpha(128), equals(Chroma.fromRGB(255, 0, 255, .5)));
      expect(colorHWB.withOpacity(0.5), equals(Chroma.fromRGB(255, 0, 255, .5)));

      expect(colorRGB.withValue('RED', 0), equals(Chroma('blue')));
      expect(colorRGB.withValue('G', 255), equals(Chroma('white')));
      expect(colorRGB.withValue('blue', 0), equals(Chroma('red')));
      expect(colorRGB.withValue('a', .5), equals(Chroma.fromRGB(255, 0, 255, .5)));

      expect(colorHSL.withValue('HUE', 0), equals(Chroma('red')));
      expect(colorHSL.withValue('S', .5), equals(Chroma('#bf40bf')));
      expect(colorHSL.withValue('lightness', .25), equals(Chroma('#800080')));
      expect(colorHSL.withValue('a', .5), equals(Chroma.fromHSL(300, 1, .5, .5)));

      expect(colorHSV.withValue('HUE', 0), equals(Chroma('red')));
      expect(colorHSV.withValue('S', .5), equals(Chroma('#ff80ff')));
      expect(colorHSV.withValue('value', .5), equals(Chroma('#800080')));
      expect(colorHSV.withValue('a', .5), equals(Chroma.fromHSV(300, 1, 1, .5)));

      expect(colorHWB.withValue('HUE', 0), equals(Chroma('red')));
      expect(colorHWB.withValue('W', .5), equals(Chroma('#ff80ff')));
      expect(colorHWB.withValue('blackness', .5), equals(Chroma('#800080')));
      expect(colorHWB.withValue('a', .5), equals(Chroma.fromHWB(300, 0, 0, .5)));

      expect(() => colorHEX.withValue('', 0), throwsArgumentError);
      expect(() => colorRGB.withValue('alpha0', 0), throwsArgumentError);
      expect(() => colorHSL.withValue('value', 0), throwsArgumentError);
      expect(() => colorHSV.withValue('RED', 0), throwsArgumentError);
      expect(() => colorHWB.withValue('null', 0), throwsArgumentError);
    });

    test('Components', () {
      expect(colorHEX.components, [255, 0, 255, 1]);
      expect(colorRGB.components, [255, 0, 255, 1]);
      expect(colorHSL.components, [300, 1, .5, 1]);
      expect(colorHSV.components, [300, 1, 1, 1]);
      expect(colorHWB.components, [300, 0, 0, 1]);

      expect(colorHEX.toCss('hex'), '#ff00ff');
      expect(colorRGB.toCss(), 'rgb(255, 0, 255)');
      expect(colorHSL.toCss(), 'hsl(300, 100%, 50%)');
      expect(colorHSV.toCss(), 'hsv(300, 100%, 100%)');
      expect(colorHWB.toCss(), 'hwb(300, 0%, 0%)');

      expect(colorHEX.toString(), 'Chroma(\'#ff00ff\')');
      expect(colorRGB.toString(), 'Chroma(\'#ff00ff\')');
      expect(colorHSL.toString(), 'Chroma(\'#ff00ff\')');
      expect(colorHSV.toString(), 'Chroma(\'#ff00ff\')');
      expect(colorHWB.toString(), 'Chroma(\'#ff00ff\')');

      expect(Chroma('ccccccc5').toCss('hex'), '#ccccccc5');
      expect(Chroma.fromRGB(0, 0, 255, .5).toCss(), 'rgba(0, 0, 255, 0.5)');

      expect(Chroma('ccccccc5').toString(), 'Chroma(\'#ccccccc5\')');
      expect(Chroma.fromRGB(0, 0, 255, .5).toString(), 'Chroma(\'#0000ff80\')');
    });

    test('Grayscale', () {
      expect(Chroma('red').grayscale(), Chroma.fromRGB(127, 127, 127));
      expect(Chroma('lime').grayscale(), Chroma.fromRGB(220, 220, 220));
      expect(Chroma('blue').grayscale(), Chroma.fromRGB(76, 76, 76));
      expect(colorHEX.grayscale(), Chroma.fromRGB(145, 145, 145));
    });

    test('Equality', () {
      expect(Chroma('black'), equals(Chroma.fromRGB(0, 0, 0)));
      expect(Chroma('black'), equals(Chroma.fromHSL(0, 0, 0)));
      expect(Chroma('black'), isNot(Chroma.fromHSL(0, 0, 0, 0)));
      expect(Chroma('white'), isNot(Chroma.fromRGB(0, 0, 0)));
      expect(Chroma('white'), isNot(Chroma.fromHSL(0, 0, 0)));
    });
  });

  group('Chroma functions', () {
    final black   = Chroma('black');
    final white   = Chroma('white');
    final red     = Chroma('red');
    final blue    = Chroma('blue');
    final fuchsia = Chroma('fuchsia');

    test('Random', () {
      expect(Chroma.random(), isA<Chroma>());
    });

    test('Lerp', () {
      expect(Chroma.lerp(white, black), equals(Chroma('#bcbcbc')));
      expect(Chroma.lerp(red, blue), equals(Chroma('#bc00bc')));
      expect(Chroma.lerp(white, black, .5, 'rgb'), equals(Chroma('gray')));
      expect(Chroma.lerp(red, blue, .5, 'rgb'), equals(Chroma('#800080')));
      expect(() => Chroma.lerp(white, black, 1, 'null'), throwsArgumentError);
    });

    test('Contrast ratio', () {
      expect(Chroma.contrast(white, black), equals(21));
      expect(Chroma.contrast(black, white), equals(21));
      expect(Chroma.contrast(white, fuchsia), equals(3.14));
      expect(Chroma.contrast(black, fuchsia), equals(6.7));
      expect(Chroma.contrast(white, white), equals(1));
    });

    test('Color difference', () {
      expect(Chroma.difference(white, fuchsia), equals(255));
    });
  });
}
