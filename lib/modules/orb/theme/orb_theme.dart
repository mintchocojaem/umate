import 'package:flutter/material.dart';

import 'orb_palette.dart';

class OrbTheme {

  ThemeMode themeMode;

  OrbTheme._internal({required this.themeMode});

  static final OrbTheme _instance = OrbTheme._internal(themeMode: ThemeMode.system);

  factory OrbTheme({ThemeMode? themeMode}) {
    _instance.themeMode = themeMode ?? _instance.themeMode;
    return _instance;
  }

  ThemeData get currentTheme {
    switch (themeMode) {
      case ThemeMode.system:
        final brightness = WidgetsBinding.instance.platformDispatcher.platformBrightness;
        return brightness == Brightness.dark ? _dark : _light;
      case ThemeMode.light:
        return _light;
      case ThemeMode.dark:
        return _dark;
    }
  }

  final ThemeData _light = ThemeData(
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

  final ThemeData _dark = ThemeData(
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
