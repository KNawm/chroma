import 'dart:math';
import 'dart:ui' show Color;

import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';

import 'package:chroma/chroma.dart';

void main() {
  // #f0f      / rgb(255, 0, 255)          / hsl(300, 100%, 50%)
  const colorFuchsia = Color(0xFFFF00FF);
  // #baaaaaaa / rgb(186, 170, 170, 0.666) / hsl(0, 10.4%, 69.8%, 0.666)
  const colorSheep = Color(0xAABAAAAA);
  // #feedbacc / rgb(254, 237, 186, 0.8)   / hsl(45, 97.1%, 86.3%, 0.8)
  const colorFeedback = Color(0xCCFEEDBA);

  group('Syntax parsing', () {
    test('Named colors', () {
      expect(chroma('fuchsia'), colorFuchsia);
      expect(chroma('FUCHSIA'), colorFuchsia);

      expect(() => chroma('fuchsias'), throwsFormatException);
    });

    test('Hexadecimal syntax', () {
      expect(chroma('#FF00FF'), colorFuchsia);
      expect(chroma('#F0F'), colorFuchsia);
      expect(chroma('#FF00FFFF'), colorFuchsia);
      expect(chroma('#F0FF'), colorFuchsia);

      expect(chroma('#ff00ff'), colorFuchsia);
      expect(chroma('#f0f'), colorFuchsia);
      expect(chroma('#ff00ffff'), colorFuchsia);
      expect(chroma('#f0ff'), colorFuchsia);

      expect(chroma('FF00FF'), colorFuchsia);
      expect(chroma('F0F'), colorFuchsia);
      expect(chroma('FF00FFFF'), colorFuchsia);
      expect(chroma('F0FF'), colorFuchsia);

      expect(chroma('ff00ff'), colorFuchsia);
      expect(chroma('f0f'), colorFuchsia);
      expect(chroma('ff00ffff'), colorFuchsia);
      expect(chroma('f0ff'), colorFuchsia);

      expect(() => chroma('asd'), throwsFormatException);
      expect(() => chroma('#baaaaaaa '), throwsFormatException);
      expect(() => chroma(' #feedbacc'), throwsFormatException);
    });

    test('rgb() syntax', () {
      expect(Chroma.rgb(255, 0, 255), colorFuchsia);
      expect(Chroma.rgb(1.0, 0, 1.0), colorFuchsia);
      expect(Chroma.rgb(255, 0, 1.0), colorFuchsia);

      // TODO FIX
      //expect(Chroma.rgb(1e2, .5e1, .5e0, .25e2), Color(0xFFFF0099));

      expect(Chroma.rgb(186, 170, 170, 0.666), colorSheep);
      expect(Chroma.rgb(186, 0.666, 0.666, 0.666), colorSheep);
      expect(Chroma.rgb((186 / 255), 170, 170, 170), colorSheep);

      expect(Chroma.rgb(254, 237, 186, 0.8), colorFeedback);
      expect(Chroma.rgb(254, 237, 186, 204), colorFeedback);

      expect(Chroma.rgba(255, 0, 255), colorFuchsia);
      expect(Chroma.rgba(1.0, 0, 1.0), colorFuchsia);
      expect(Chroma.rgba(255, 0, 1.0), colorFuchsia);

      //todo write tests with out of range values
    });

    test('hsl() syntax', () {
      expect(Chroma.hsl(300, 1.0, 0.5, 1.0), colorFuchsia);
      expect(Chroma.hsl(660, 1.0, 0.5, 1.0), colorFuchsia);
      expect(
          Chroma.hsl(300 * 200 / 180, 1, .5, 1, AngleUnits.grad), colorFuchsia);
      expect(
          Chroma.hsl(300 * pi / 180, 1, .5, 1, AngleUnits.rad), colorFuchsia);
      expect(Chroma.hsl(300 / 360, 1.0, .5, 1, AngleUnits.turn), colorFuchsia);

      expect(Chroma.hsl(0, 0.104, 0.698, 0.666), colorSheep);

      expect(Chroma.hsl(45, 0.971, 0.863, 0.8), colorFeedback);

      expect(Chroma.hsla(300, 1.0, 0.5, 1.0), colorFuchsia);
      expect(Chroma.hsla(660, 1.0, 0.5, 1.0), colorFuchsia);
      expect(Chroma.hsla(300 / 360, 1.0, .5, 1, AngleUnits.turn), colorFuchsia);

      //todo write tests with out of range values
    });

    test('hwb() syntax', () {
      expect(Chroma.hwb(300, 0, 0, 1.0), colorFuchsia);
      expect(Chroma.hwb(660, 0, 0, 1.0), colorFuchsia);
      expect(
          Chroma.hwb(300 * 200 / 180, 0, 0, 1, AngleUnits.grad), colorFuchsia);
      expect(Chroma.hwb(300 * pi / 180, 0, 0, 1, AngleUnits.rad), colorFuchsia);
      expect(Chroma.hwb(300 / 360, 0, 0, 1, AngleUnits.turn), colorFuchsia);

      expect(Chroma.hwb(0, 0.665, 0.27, 0.666), colorSheep);

      expect(Chroma.hwb(45, 0.729, 0.004, 0.8), colorFeedback);

      expect(Chroma.hwba(300, 0, 0, 1.0), colorFuchsia);

      //todo write tests with out of range values
    });
  });
}
