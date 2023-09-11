import 'package:flutter/material.dart';

import 'orb_palette.dart';

class OrbTheme {
  final bool isDark;
  ThemeData _currentTheme;

  OrbTheme({required this.isDark}) : _currentTheme = isDark ? _dark : _light;

  set isDark(bool value) {
    _currentTheme = value ? _dark : _light;
  }

  ThemeData get currentTheme => _currentTheme;

  static final ThemeData _light = ThemeData(
    useMaterial3: true,
    splashColor: Colors.transparent,
    highlightColor: Colors.transparent,
    textTheme: const TextTheme(
      titleLarge: TextStyle(
        fontSize: 24,
      ),
      titleMedium: TextStyle(
        fontSize: 20,
      ),
      titleSmall: TextStyle(
        fontSize: 16,
      ),
      bodyLarge: TextStyle(
        fontSize: 20,
      ),
      bodyMedium: TextStyle(
        fontSize: 16,
      ),
      bodySmall: TextStyle(
        fontSize: 12,
      ),
    ).apply(fontFamily: 'SpoqaHanSansNeo'),
    brightness: Brightness.light,
    colorScheme: const ColorScheme.light(
      primary: OrbPalette.blue,
      onPrimary: OrbPalette.white,
      secondary: OrbPalette.lightBlue,
      onSecondary: OrbPalette.white,
      surface: OrbPalette.white,
      onSurface: OrbPalette.darkGrey,
      surfaceVariant: OrbPalette.white,
      background: OrbPalette.white,
      onBackground: OrbPalette.whiteGrey,
    ),
  );

  static final ThemeData _dark = ThemeData(
    useMaterial3: true,
    splashColor: Colors.transparent,
    highlightColor: Colors.transparent,
    textTheme: const TextTheme(
      titleLarge: TextStyle(
        fontSize: 24,
      ),
      titleMedium: TextStyle(
        fontSize: 22,
      ),
      titleSmall: TextStyle(
        fontSize: 18,
      ),
      bodyLarge: TextStyle(
        fontSize: 18,
      ),
      bodyMedium: TextStyle(
        fontSize: 16,
      ),
      bodySmall: TextStyle(
        fontSize: 14,
      ),
    ).apply(fontFamily: 'SpoqaHanSansNeo'),
    brightness: Brightness.dark,
    colorScheme: const ColorScheme.dark(
      primary: OrbPalette.blue,
      onPrimary: OrbPalette.white,
      secondary: OrbPalette.lightBlue,
      onSecondary: OrbPalette.white,
      surface: OrbPalette.black,
      onSurface: OrbPalette.whiteGrey,
      surfaceVariant: OrbPalette.black,
      background: OrbPalette.black,
      onBackground: OrbPalette.darkGrey,
    ),
  );

}
