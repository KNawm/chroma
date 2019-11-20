import 'package:flutter/painting.dart' show HSLColor;
import 'package:chroma/src/chroma_base.dart' show AngleUnits;

import 'utils.dart';

// ignore: public_member_api_docs
int fromHSL(double hue, double saturation, double lightness,
    [double alpha = 1.0, AngleUnits angleUnit = AngleUnits.deg]) {
  hue = convertToDegrees(hue, angleUnit);
  hue %= 360; // [HSLColor.hue] range is [0.0, 360.0]

  return HSLColor.fromAHSL(alpha, hue, saturation, lightness).toColor().value;
}
