import 'dart:ui' show Color;

import 'package:flutter_test/flutter_test.dart';
import 'package:chroma/chroma.dart';

void main() {
  // #f0f / rgb(255, 0, 255) / hsl(300, 100%, 50%)
  const colorFuchsia = Color(0xFFFF00FF);
  // #baaaaaaa / rgba(186, 170, 170, 0.6666666666666666) / hsla(0, 10%, 70%, 0.6666666666666666)
  const colorSheep = Color(0xAABAAAAA);
  // #feedbacc / rgba(254, 237, 186, 0.8) / hsla(45, 97%, 86%, 0.8)
  const colorFeedback = Color(0xccfeedba);

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

    test('Functional syntax', () {
      expect(Chroma.rgb(255, 0, 255), colorFuchsia);
      expect(Chroma.rgb(1.0, 0, 1.0), colorFuchsia);
      expect(Chroma.rgb(255, 0, 1.0), colorFuchsia);

      expect(Chroma.rgb(186, 170, 170, 0.666), colorSheep);
      expect(Chroma.rgb(186, 0.666, 0.666, 0.666), colorSheep);
      expect(Chroma.rgb((186 / 255), 170, 170, 170), colorSheep);

      expect(Chroma.rgb(254, 237, 186, 0.8), colorFeedback);
      expect(Chroma.rgb(254, 237, 186, 204), colorFeedback);

      expect(Chroma.rgba(255, 0, 255), colorFuchsia);
      expect(Chroma.rgba(1.0, 0, 1.0), colorFuchsia);
      expect(Chroma.rgba(255, 0, 1.0), colorFuchsia);
    });
  });
}
