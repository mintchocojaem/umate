import 'package:flutter/material.dart';

enum OrbFontWeight {
  light(FontWeight.w400),
  regular(FontWeight.w500),
  medium(FontWeight.w600),
  bold(FontWeight.w900);

  final FontWeight weight;

  const OrbFontWeight(this.weight);
}

class OrbTextStyle {
  final Color? color;
  final double? fontSize;
  final OrbFontWeight? fontWeight;

  OrbTextStyle({
    this.color,
    this.fontSize,
    this.fontWeight,
  });

  TextStyle toTextStyle() {
    return TextStyle(
      color: color,
      fontSize: fontSize,
      fontWeight: fontWeight?.weight,
      fontFamily: 'SpoqaHanSansNeo',
    );
  }

  OrbTextStyle copyWith({
    Color? color,
    double? fontSize,
    OrbFontWeight? fontWeight,
  }) {
    return OrbTextStyle(
      color: color ?? this.color,
      fontSize: fontSize ?? this.fontSize,
      fontWeight: fontWeight ?? this.fontWeight,
    );
  }
}

class OrbTextTheme {
  static final headline = OrbTextStyle(
    fontSize: 26,
    fontWeight: OrbFontWeight.bold,
  );
  static final titleLarge = OrbTextStyle(
    fontSize: 24,
    fontWeight: OrbFontWeight.medium,
  );
  static final titleMedium = OrbTextStyle(
    fontSize: 22,
    fontWeight: OrbFontWeight.medium,
  );
  static final titleSmall = OrbTextStyle(
    fontSize: 20,
    fontWeight: OrbFontWeight.medium,
  );
  static final bodyLarge = OrbTextStyle(
    fontSize: 18,
    fontWeight: OrbFontWeight.regular,
  );
  static final bodyMedium = OrbTextStyle(
    fontSize: 16,
    fontWeight: OrbFontWeight.regular,
  );
  static final bodySmall = OrbTextStyle(
    fontSize: 14,
    fontWeight: OrbFontWeight.regular,
  );
  static final caption = OrbTextStyle(
    fontSize: 12,
    fontWeight: OrbFontWeight.light,
  );
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
}
