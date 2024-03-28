import 'package:flutter/foundation.dart';
import 'package:flutter/painting.dart';
@immutable
sealed class LightPalette {
  static const Color lightSkyBlue = Color(0xFFEBF2FE); // sub primary
  static const Color vividBlue = Color(0xFF4880ED); // primary
  static const Color palePink = Color(0xFFFDEEEE); // sub error
  static const Color brightRed = Color(0xFFDE5257); // error
  static const Color pureWhite = Color(0xFFFFFFFF); // surface, dialog background, bottom sheet
  static const Color lightGrayishBlue = Color(0xFFF3F4F6); // background, dialog surface, disabled button
  //static const Color coolGrey = Color(0xFFD2D6DA); // general icons
  static const Color steelGray = Color(0xFFB2B8C0); // bottom icon, post icon, appbar icon
  static const Color slateGray = Color(0xFF8D969F); // post hint(x), snack bar, disabled button text
  static const Color darkSlateGray = Color(0xFF636E7E); // on snackBar
  static const Color deeperSlateGray = Color(0xFF505866); // post body, tonal button
  static const Color darkestSlateGray = Color(0xFF363D4C); // post subtitle
  static const Color charcoalBlue = Color(0xFF1A1E27); // on bottom icon, post title
}

@immutable
sealed class DarkPalette {
  static const Color vividBlue = Color(0xFF4880ED); // primary
  static const Color deepNavyBlue = Color(0xFF19233C); // sub primary
  static const Color brightRed = Color(0xFFDE5257); // error
  static const Color darkBurgundy = Color(0xFF372529); // sub error
  static const Color pureWhite = Color(0xFFFFFFFF); // on bottom icon, post title
  static const Color silverSand = Color(0xFFE4E3E6); // post subtitle
  static const Color lightSlateGray = Color(0xFFC2C1C6); // post body
  static const Color steelGray = Color(0xFFB2B8C0); // post icon
  static const Color cadetGray = Color(0xFF7E7F87); // disabled button text
  static const Color darkerSteelGray = Color(0xFF62626c); // bottom icon, appbar icon
  //static const Color onyxGray = Color(0xFF4D4D59); // general icon -> darkSteelGray
  static const Color gunmetalGray = Color(0xFF3C3C46); // snack bar
  static const Color outerSpaceGray = Color(0xFF3F3F4A); // on snack bar
  static const Color eerieBlack = Color(0xFF2C2C34); // dialog surface, tonal button
  static const Color raisinBlack = Color(0xFF1D1C20); // dialog background
  static const Color charcoal = Color(0xFF18171D); // surface, bottom sheet
  static const Color richBlack = Color(0xFF100F12); // background
}