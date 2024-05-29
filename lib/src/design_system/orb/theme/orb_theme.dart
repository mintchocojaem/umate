import 'package:flutter/material.dart';

import '../orb.dart';

class OrbThemeData {
  final OrbTextTheme textTheme;
  final OrbPalette palette;

  OrbThemeData._({
    required this.textTheme,
    required this.palette,
  });

  static OrbThemeData _instance = OrbThemeData._light();

  factory OrbThemeData._light() => OrbThemeData._(
        textTheme: OrbDefaultLightTextTheme(),
        palette: OrbLightPalette(),
      );

  factory OrbThemeData._dark() => OrbThemeData._(
        textTheme: OrbDefaultLightTextTheme(),
        palette: OrbDarkPalette(),
      );

  setDarkMode(bool value) {
    _instance = value ? OrbThemeData._dark() : OrbThemeData._light();
  }

  static OrbThemeData of(BuildContext context) {
    bool isDark = Theme.of(context).brightness == Brightness.dark;
    return isDark ? _instance : _instance;
  }

  const OrbThemeData({
    required this.textTheme,
    required this.palette,
  });
}
