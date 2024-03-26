import 'package:flutter/painting.dart';
class LightPalette {
  static const Color lightSkyBlue = Color(0xFFEBF2FE); // sub primary
  static const Color vividBlue = Color(0xFF4880ED); // primary
  static const Color palePink = Color(0xFFFDEEEE); // sub error
  static const Color brightRed = Color(0xFFDE5257); // error
  static const Color pureWhite = Color(0xFFFFFFFF); // surface, dialog background, bottom sheet
  static const Color lightGrayishBlue = Color(0xFFF3F4F6); // background, dialog surface
  //static const Color coolGrey = Color(0xFFD2D6DA); // general icon -> steelGray
  static const Color steelGray = Color(0xFFB2B8C0); // bottom icon, post icon, appbar icon
  static const Color slateGray = Color(0xFF8D969F); // post hint, snack bar
  static const Color darkSlateGray = Color(0xFF636E7E); // on snackBar
  static const Color deeperSlateGray = Color(0xFF505866); // post body, tonal button
  static const Color darkestSlateGray = Color(0xFF363D4C); // post subtitle
  static const Color charcoalBlue = Color(0xFF1A1E27); // on bottom icon, post title
}

class DarkPalette {
  static const Color vividBlue = Color(0xFF4880ED); // primary
  static const Color deepNavyBlue = Color(0xFF19233C); // sub primary
  static const Color brightRed = Color(0xFFDE5257); // error
  static const Color darkBurgundy = Color(0xFF372529); // sub error
  static const Color pureWhite = Color(0xFFFFFFFF); // on bottom icon, post title
  static const Color silverSand = Color(0xFFE4E3E6); // post subtitle
  static const Color lightSlateGray = Color(0xFFC2C1C6); // post body
  static const Color steelGray = Color(0xFFB2B8C0); // post icon
  static const Color cadetGray = Color(0xFF7E7F87); // post hint
  static const Color darkerSteelGray = Color(0xFF62626c); // bottom icon, appbar icon
  //static const Color onyxGray = Color(0xFF4D4D59); // general icon -> darkSteelGray
  static const Color gunmetalGray = Color(0xFF3C3C46); // snack bar
  static const Color outerSpaceGray = Color(0xFF3F3F4A); // on snack bar
  static const Color eerieBlack = Color(0xFF2C2C34); // dialog surface, tonal button
  static const Color raisinBlack = Color(0xFF1D1C20); // dialog background
  static const Color charcoal = Color(0xFF18171D); // surface, bottom sheet
  static const Color richBlack = Color(0xFF100F12); // background
}

abstract class OrbPalette {
  Color get primary;

  Color get subPrimary;

  Color get error;

  Color get subError;

  Color get background;

  Color get surface;

  Color get dialog;

  Color get bottomSheet;

  Color get content;

  Color get icon;

  Color get snackBar;

  Color get onSnackBar;

  Color get title;

  Color get subtitle;

  Color get body;

  Color get hint;
}

class OrbLightPalette implements OrbPalette {
  @override
  final Color primary = LightPalette.vividBlue;

  @override
  final Color subPrimary = LightPalette.lightSkyBlue;

  @override
  final Color error = LightPalette.brightRed;

  @override
  final Color subError = LightPalette.palePink;

  @override
  final Color background = LightPalette.lightGrayishBlue;

  @override
  final Color surface = LightPalette.pureWhite;

  @override
  final Color dialog = LightPalette.lightGrayishBlue;

  @override
  final Color bottomSheet = LightPalette.pureWhite;

  @override
  final Color content = LightPalette.steelGray;

  @override
  final Color icon = LightPalette.steelGray;

  @override
  final Color snackBar = LightPalette.slateGray;

  @override
  final Color onSnackBar = LightPalette.darkSlateGray;

  @override
  final Color title = LightPalette.charcoalBlue;

  @override
  final Color subtitle = LightPalette.darkestSlateGray;

  @override
  final Color body = LightPalette.deeperSlateGray;

  @override
  final Color hint = LightPalette.slateGray;
}

class OrbDarkPalette implements OrbPalette {
  @override
  final Color primary = DarkPalette.vividBlue;

  @override
  final Color subPrimary = DarkPalette.deepNavyBlue;

  @override
  final Color error = DarkPalette.brightRed;

  @override
  final Color subError = DarkPalette.darkBurgundy;

  @override
  final Color background = DarkPalette.richBlack;

  @override
  final Color surface = DarkPalette.charcoal;

  @override
  final Color dialog = DarkPalette.raisinBlack;

  @override
  final Color bottomSheet = DarkPalette.charcoal;

  @override
  final Color content = DarkPalette.lightSlateGray;

  @override
  final Color icon = DarkPalette.darkerSteelGray;

  @override
  final Color snackBar = DarkPalette.gunmetalGray;

  @override
  final Color onSnackBar = DarkPalette.outerSpaceGray;

  @override
  final Color title = DarkPalette.pureWhite;

  @override
  final Color subtitle = DarkPalette.silverSand;

  @override
  final Color body = DarkPalette.lightSlateGray;

  @override
  final Color hint = DarkPalette.cadetGray;
}