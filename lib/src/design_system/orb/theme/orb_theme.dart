import 'package:danvery/src/design_system/orb/theme/palette.dart';
import 'package:flutter/material.dart';

class OrbTextTheme {
  final OrbPalette _palette;

  late final TextStyle headline;
  late final TextStyle titleLarge;
  late final TextStyle titleMedium;
  late final TextStyle titleSmall;
  late final TextStyle bodyLarge;
  late final TextStyle bodyMedium;
  late final TextStyle bodySmall;
  late final TextStyle caption;

  OrbTextTheme(this._palette) {
    _init();
  }

  void _init() {
    headline = TextStyle(
      fontSize: 26,
      fontFamily: 'SpoqaHanSansNeo',
      fontWeight: FontWeight.w600,
      color: _palette.title,
    );
    titleLarge = TextStyle(
      fontSize: 24,
      fontFamily: 'SpoqaHanSansNeo',
      fontWeight: FontWeight.w500,
      color: _palette.title,
    );
    titleMedium = TextStyle(
      fontSize: 22,
      fontFamily: 'SpoqaHanSansNeo',
      fontWeight: FontWeight.w400,
      color: _palette.title,
    );
    titleSmall = TextStyle(
      fontSize: 20,
      fontFamily: 'SpoqaHanSansNeo',
      fontWeight: FontWeight.w400,
      color: _palette.title,
    );
    bodyLarge = TextStyle(
      fontSize: 18,
      fontFamily: 'SpoqaHanSansNeo',
      fontWeight: FontWeight.w300,
      color: _palette.body,
    );
    bodyMedium = TextStyle(
      fontSize: 16,
      fontFamily: 'SpoqaHanSansNeo',
      fontWeight: FontWeight.w300,
      color: _palette.body,
    );
    bodySmall = TextStyle(
      fontSize: 14,
      fontFamily: 'SpoqaHanSansNeo',
      fontWeight: FontWeight.w300,
      color: _palette.body,
    );
    caption = TextStyle(
      fontSize: 12,
      fontFamily: 'SpoqaHanSansNeo',
      fontWeight: FontWeight.w200,
      color: _palette.hint,
    );
  }
}

class OrbTheme {

  of(context) {
    return Theme.of(context);
  }

}
