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
      expect(chroma('#f09'), expectedColor);
      expect(chroma('#F09'), expectedColor);
      expect(chroma('#ff0099'), expectedColor);
      expect(chroma('#FF0099'), expectedColor);
      expect(chroma('#0000ffff'), Color.fromRGBO(0, 0, 255, 1));
      expect(chroma('#0000ff00'), Color.fromRGBO(0, 0, 255, 0));
      expect(chroma('#00ff'), Color.fromRGBO(0, 0, 255, 1));
      expect(chroma('#00f0'), Color.fromRGBO(0, 0, 255, 0));
      expect(chroma('#f00f'), Color.fromRGBO(255, 0, 0, 1));
      expect(chroma('#0f0f'), Color.fromRGBO(0, 255, 0, 1));
      expect(chroma('#ff0000ff'), Color.fromRGBO(255, 0, 0, 1));
      expect(chroma('#00ff00ff'), Color.fromRGBO(0, 255, 0, 1));
      expect(chroma('#00f8'), Color.fromRGBO(0, 255, 0, 1));
    });

    test('Functional syntax', () {
      expect(rgb(255, 0, 153), expectedColor);
      expect(rgb(255, 0, 153), expectedColor);
      /*expect(rgb(255, 0, 153.0), expectedColor));
      expect(rgb(100%,0%,60%), expectedColor));
      expect(rgb(100%, 0%, 60%), expectedColor));
      expect(rgb(100%, 0, 60%), expectedColor));
      expect(rgb(255 0 153), expectedColor));
      expect(rgb(100%,0%,60%), expectedColor));*/
    });

    test('Hexadecimal syntax with alpha value', () {
      expect(chroma('#f09f'), expectedColor);
      expect(chroma('#F09F'), expectedColor);
      expect(chroma('#ff0099ff'), expectedColor);
      expect(chroma('#FF0099FF'), expectedColor);
    });

    /* NOT IMPLEMENTED YET
    test('Functional syntax with alpha value', () {
      expect(rgb(255, 0, 153, 1), expectedColor));
      expect(rgb(255, 0, 153, 100%), expectedColor));
    });

    test('Whitespace syntax', () {
      expect(rgb(255 0 153 / 1), expectedColor));
      expect(rgb(255 0 153 / 100%), expectedColor));
    });

    test('Functional syntax with floats value', () {
      expect(rgb(255, 0, 153.6, 1), expectedColor));
      expect(rgb(1e2, .5e1, .5e0, +.25e2%), expectedColor));
    });*/
  });
}
