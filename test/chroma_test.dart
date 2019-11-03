import 'dart:ui' show Color;

import 'package:flutter_test/flutter_test.dart';
import 'package:chroma/chroma.dart';

void main() {
  Color expectedColor;

  // TODO implementar tests https://developer.mozilla.org/en-US/docs/Web/CSS/color_value

  group('RGB syntax parsing', () {
    expectedColor = Color(0xFFFF0099);

    test('Hexadecimal syntax', () {
      //expect(chroma('#f09'), equals(expectedColor));
      //expect(chroma('#F09'), equals(expectedColor));
      expect(chroma('#ff0099'), equals(expectedColor));
      expect(chroma('#FF0099'), equals(expectedColor));
    });
  });
}
