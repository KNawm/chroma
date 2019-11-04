import 'dart:ui' show Color;

import 'package:flutter_test/flutter_test.dart';
import 'package:chroma/chroma.dart';

void main() {
  Color expectedColor;

  // TODO implementar tests https://developer.mozilla.org/en-US/docs/Web/CSS/color_value
  // https://meyerweb.com/eric/thoughts/2019/04/01/color-me-face1e55/

  group('RGB syntax parsing', () {
    expectedColor = Color(0xFFFF0099);

    test('Hexadecimal syntax', () {
      expect(chroma('#f09'), equals(expectedColor));
      expect(chroma('#F09'), equals(expectedColor));
      expect(chroma('#ff0099'), equals(expectedColor));
      expect(chroma('#FF0099'), equals(expectedColor));
    });

    test('Functional syntax', () {
      expect(rgb(255, 0, 153), equals(expectedColor));
      expect(rgb(255, 0, 153), equals(expectedColor));
      /*expect(rgb(255, 0, 153.0), equals(expectedColor));
      expect(rgb(100%,0%,60%), equals(expectedColor));
      expect(rgb(100%, 0%, 60%), equals(expectedColor));
      expect(rgb(100%, 0, 60%), equals(expectedColor));
      expect(rgb(255 0 153), equals(expectedColor));
      expect(rgb(100%,0%,60%), equals(expectedColor));*/
    });

    test('Hexadecimal syntax with alpha value', () {
      expect(chroma('#f09f'), equals(expectedColor));
      expect(chroma('#F09F'), equals(expectedColor));
      expect(chroma('#ff0099ff'), equals(expectedColor));
      expect(chroma('#FF0099FF'), equals(expectedColor));
    });

    /* NOT IMPLEMENTED YET
    test('Functional syntax with alpha value', () {
      expect(rgb(255, 0, 153, 1), equals(expectedColor));
      expect(rgb(255, 0, 153, 100%), equals(expectedColor));
    });

    test('Whitespace syntax', () {
      expect(rgb(255 0 153 / 1), equals(expectedColor));
      expect(rgb(255 0 153 / 100%), equals(expectedColor));
    });

    test('Functional syntax with floats value', () {
      expect(rgb(255, 0, 153.6, 1), equals(expectedColor));
      expect(rgb(1e2, .5e1, .5e0, +.25e2%), equals(expectedColor));
    });*/
  });
}
