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

    test('XYZ syntax', () {
      expect(Chroma.fromXYZ(0.5928, 0.2848, 0.9696).hashCode, colorFuchsia);
      expect(Chroma.fromXYZ(0.4187, 0.4209, 0.4394, 0.666).hashCode, colorSheep);
      expect(Chroma.fromXYZ(0.8002, 0.8518, 0.5867, 0.8).hashCode, colorFeedback);
      expect(Chroma.fromXYZ(0.5, 0.5, 0.5).hashCode, Color(0xFFCCB7B4).hashCode);

      // TODO: Tests with out of range values and examples with scientific notation.
    });

    test('LAB syntax', () {
      expect(Chroma.fromLAB(60.1697, 93.5511, -60.5002).hashCode, colorFuchsia);
      expect(Chroma.fromLAB(70.9941, 5.9679, 2.2011, 0.666).hashCode, colorSheep);
      expect(Chroma.fromLAB(94.2008, 0.3523, 27.0005, 0.8).hashCode, colorFeedback);
      expect(Chroma.fromLAB(50, 64, 64).hashCode, Color(0xFFDC3400).hashCode);
      expect(Chroma.fromLAB(1, 0, 0).hashCode, Color(0xFF040404).hashCode);
      expect(Chroma.fromLAB(20, 0, 0).hashCode, Color(0xFF303030).hashCode);

      // TODO: Tests with out of range values and examples with scientific notation.
    });

    test('LCH syntax', () {
      expect(Chroma.fromLCH(60.1697, 111.4077, 327.1094).hashCode, colorFuchsia);
      expect(Chroma.fromLCH(70.9942, 6.3604, 20.2595, 0.666).hashCode, colorSheep);
      expect(Chroma.fromLCH(94.2008, 27.0042, 89.2550, 0.8).hashCode, colorFeedback);
      expect(Chroma.fromLCH(50, 66, 180).hashCode, Color(0xFF009075).hashCode);
      expect(Chroma.fromLCH(0, 0, 0).hashCode, Color(0xFF000000).hashCode);

      // TODO: Tests with out of range values and examples with scientific notation.
    });
  });

  group('Colors', () {
    final colorHEX = Chroma('fuchsia');
    final colorRGB = Chroma.fromRGB(255, 0, 255);
    final colorHSL = Chroma.fromHSL(300, 1, .5);
    final colorHSV = Chroma.fromHSV(300, 1, 1);
    final colorHWB = Chroma.fromHWB(300, 0, 0);
    final colorXYZ = Chroma.fromXYZ(0.5, 0.5, 0.5);
    final colorLAB = Chroma.fromLAB(50, 64, 64);
    final colorLCH = Chroma.fromLCH(60.1697, 111.4077, 327.1094);

    test('Format', () {
      expect(colorHEX.format, equals('rgb'));
      expect(colorRGB.format, equals('rgb'));
      expect(colorHSL.format, equals('hsl'));
      expect(colorHSV.format, equals('hsv'));
      expect(colorHWB.format, equals('hwb'));
      expect(colorXYZ.format, equals('xyz'));
      expect(colorLAB.format, equals('lab'));
      expect(colorLCH.format, equals('lch'));
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

      expect(colorXYZ.withValue('X', 0), equals(Chroma('#E7FAAF')));
      expect(colorXYZ.withValue('y', 1), equals(Chroma('#DD29A0')));
      expect(colorXYZ.withValue('Z', 0), equals(Chroma('#EEB30C')));
      expect(colorXYZ.withValue('a', 0), equals(Chroma('#CCB7B4').withOpacity(0)));

      expect(colorLAB.withValue('L', 0), equals(Chroma('#4D0000')));
      expect(colorLAB.withValue('a', 0), equals(Chroma('#8A7600')));
      expect(colorLAB.withValue('B', 0), equals(Chroma('#D3377A')));
      expect(colorLAB.withValue('alpha', 0), equals(Chroma('#DC3400').withOpacity(0)));

      expect(colorLCH, equals(Chroma('#FF00FF')));
      expect(colorLCH.withValue('C', 0), equals(Chroma.fromRGB(145, 145, 145)));
      expect(colorLCH.withValue('h', 70), equals(Chroma.fromRGB(222, 115, 0)));
      expect(colorLCH.withValue('alpha', 0), equals(Chroma('#FF00FF').withOpacity(0)));

      expect(() => colorHEX.withValue('', 0), throwsArgumentError);
      expect(() => colorRGB.withValue('alpha0', 0), throwsArgumentError);
      expect(() => colorHSL.withValue('value', 0), throwsArgumentError);
      expect(() => colorHSV.withValue('RED', 0), throwsArgumentError);
      expect(() => colorHWB.withValue('null', 0), throwsArgumentError);
      expect(() => colorXYZ.withValue('luma', 0), throwsArgumentError);
      expect(() => colorLAB.withValue('l*', 0), throwsArgumentError);
    });

    test('Components', () {
      expect(colorHEX.components, [255, 0, 255, 1]);
      expect(colorRGB.components, [255, 0, 255, 1]);
      expect(colorHSL.components, [300, 1, .5, 1]);
      expect(colorHSV.components, [300, 1, 1, 1]);
      expect(colorHWB.components, [300, 0, 0, 1]);
      expect(colorXYZ.components, [0.5, 0.5, 0.5, 1]);
      expect(colorLAB.components, [50, 64, 64, 1]);

      expect(colorHEX.toCSS('hex'), '#ff00ff');
      expect(colorRGB.toCSS(), 'rgb(255, 0, 255)');
      expect(colorHSL.toCSS(), 'hsl(300, 100%, 50%)');
      expect(colorHSV.toCSS(), 'hsv(300, 100%, 100%)');
      expect(colorHWB.toCSS(), 'hwb(300, 0%, 0%)');
      expect(colorXYZ.toCSS, throwsUnsupportedError);
      expect(colorLAB.toCSS, throwsUnsupportedError);

      expect(colorHEX.toString(), 'Chroma(\'#ff00ff\')');
      expect(colorRGB.toString(), 'Chroma(\'#ff00ff\')');
      expect(colorHSL.toString(), 'Chroma(\'#ff00ff\')');
      expect(colorHSV.toString(), 'Chroma(\'#ff00ff\')');
      expect(colorHWB.toString(), 'Chroma(\'#ff00ff\')');
      expect(colorXYZ.toString(), 'Chroma(\'#ccb7b4\')');
      expect(colorLAB.toString(), 'Chroma(\'#dc3400\')');

      expect(Chroma('ccccccc5').toCSS('hex'), '#ccccccc5');
      expect(Chroma.fromRGB(0, 0, 255, .5).toCSS(), 'rgba(0, 0, 255, 0.5)');

      expect(Chroma('ccccccc5').toString(), 'Chroma(\'#ccccccc5\')');
      expect(Chroma.fromRGB(0, 0, 255, .5).toString(), 'Chroma(\'#0000ff80\')');
    });

    test('Grayscale', () {
      expect(Chroma('red').grayscale, Chroma.fromRGB(127, 127, 127));
      expect(Chroma('lime').grayscale, Chroma.fromRGB(220, 220, 220));
      expect(Chroma('blue').grayscale, Chroma.fromRGB(76, 76, 76));
      expect(colorHEX.grayscale, Chroma.fromRGB(145, 145, 145));
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
