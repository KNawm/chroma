import 'package:flutter_test/flutter_test.dart';

import 'package:chroma/chroma.dart';

void main() {
  group('A group of tests', () {
    Chroma chroma;

    setUp(() {
      chroma = Chroma();
    });

    test('First Test', () {
      expect(chroma.isAwesome, isTrue);
    });
  });
}
