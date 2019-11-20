import 'package:flutter/painting.dart' show HSVColor;
import 'package:chroma/src/chroma_base.dart' show AngleUnits;

import 'utils.dart';

// ignore: public_member_api_docs
int fromHSV(double hue, double saturation, double value,
    [double alpha = 1.0, AngleUnits angleUnit = AngleUnits.deg]) {
  hue = convertToDegrees(hue, angleUnit);
  hue %= 360; // [HSVColor.hue] range is [0.0, 360.0]

  return HSVColor.fromAHSV(alpha, hue, saturation, value).toColor().value;
}
