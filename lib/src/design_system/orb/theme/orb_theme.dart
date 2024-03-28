import 'package:flutter/material.dart';

enum OrbFontWeight {
  light(FontWeight.w400),
  regular(FontWeight.w500),
  medium(FontWeight.w600),
  bold(FontWeight.w900);

  final FontWeight weight;

  const OrbFontWeight(this.weight);
}

class OrbTextTheme {
  final OrbFontWeight fontWeight;
  final double fontSize;
  final Color? color;
  final String fontFamily = 'SpoqaHanSansNeo';

  const OrbTextTheme._({
    required this.fontWeight,
    required this.fontSize,
    this.color,
  });

  factory OrbTextTheme.headline() => const OrbTextTheme._(
      fontWeight: OrbFontWeight.bold, fontSize: 26, color: null);

  factory OrbTextTheme.titleLarge() => const OrbTextTheme._(
      fontWeight: OrbFontWeight.bold, fontSize: 24, color: null);

  factory OrbTextTheme.titleMedium() => const OrbTextTheme._(
      fontWeight: OrbFontWeight.bold, fontSize: 22, color: null);

  factory OrbTextTheme.titleSmall() => const OrbTextTheme._(
      fontWeight: OrbFontWeight.medium, fontSize: 20, color: null);

  factory OrbTextTheme.bodyLarge() => const OrbTextTheme._(
      fontWeight: OrbFontWeight.regular, fontSize: 18, color: null);

  factory OrbTextTheme.bodyMedium() => const OrbTextTheme._(
      fontWeight: OrbFontWeight.regular, fontSize: 16, color: null);

  factory OrbTextTheme.bodySmall() => const OrbTextTheme._(
      fontWeight: OrbFontWeight.regular, fontSize: 14, color: null);

  factory OrbTextTheme.caption() => const OrbTextTheme._(
      fontWeight: OrbFontWeight.light, fontSize: 12, color: null);

}

enum OrbThemeMode { light, dark, system }

class OrbTheme {
  OrbTheme._();

  static final OrbTheme _instance = OrbTheme._();

  factory OrbTheme() => _instance;

  OrbThemeMode _themeMode = OrbThemeMode.system;

  OrbTheme.setThemeMode(OrbThemeMode themeMode) {
    _themeMode = themeMode;
  }

  OrbThemeMode getThemeMode(BuildContext context) {
    final Brightness brightness = MediaQuery.of(context).platformBrightness;
    switch (_themeMode) {
      case OrbThemeMode.light:
        return OrbThemeMode.light;
      case OrbThemeMode.dark:
        return OrbThemeMode.dark;
      case OrbThemeMode.system:
        return brightness == Brightness.dark
            ? OrbThemeMode.dark
            : OrbThemeMode.light;
    }
  }

  bool isDarkMode(BuildContext context) {
    return getThemeMode(context) == OrbThemeMode.dark;
  }

  bool isLightMode(BuildContext context) {
    return getThemeMode(context) == OrbThemeMode.light;
  }
}
