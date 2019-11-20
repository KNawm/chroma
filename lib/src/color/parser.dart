import 'hex.dart';
import 'named_colors.dart';

export 'hsl.dart';
export 'hsv.dart';
export 'hwb.dart';
export 'rgb.dart';

// ignore: public_member_api_docs
int fromString(String value) {
  value = value.toLowerCase();

  return fromNamed(value) ?? fromHEX(value);
}