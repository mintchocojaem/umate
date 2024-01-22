import 'package:danvery/src/module/orb/theme/orb_palette.dart';
import 'package:flutter/material.dart';

class OrbTheme {
  late ThemeMode _themeMode;

  OrbTheme._internal() {
    _themeMode = ThemeMode.system;
  }

  static final OrbTheme _instance = OrbTheme._internal();

  factory OrbTheme() {
    return _instance;
  }

  ThemeData get systemTheme {
    final brightness =
        WidgetsBinding.instance.platformDispatcher.platformBrightness;
    return brightness == Brightness.dark ? _darkTheme : _lightTheme;
  }

  set setThemeMode(ThemeMode themeMode) {
    _themeMode = themeMode;
  }

  ThemeData get getThemeMode {
    switch (_themeMode) {
      case ThemeMode.system:
        final brightness =
            WidgetsBinding.instance.platformDispatcher.platformBrightness;
        return brightness == Brightness.dark ? _darkTheme : _lightTheme;
      case ThemeMode.light:
        return _lightTheme;
      case ThemeMode.dark:
        return _darkTheme;
    }
  }

  final TextTheme _textTheme = const TextTheme(
    titleLarge: TextStyle(
      fontSize: 22,
    ),
    titleMedium: TextStyle(
      fontSize: 20,
    ),
    titleSmall: TextStyle(
      fontSize: 18,
    ),
    bodyLarge: TextStyle(
      fontSize: 16,
    ),
    bodyMedium: TextStyle(
      fontSize: 14,
    ),
    bodySmall: TextStyle(
      fontSize: 12,
    ),
  );

  ThemeData get _lightTheme {
    return ThemeData(
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      colorScheme: ColorScheme.light(
        brightness: Brightness.light,
        primary: OrbPalette.mainColor,
        onPrimary: OrbPalette.onMainColor,
        secondary: OrbPalette.subColor,
        onSecondary: OrbPalette.onSubColor,
        background: OrbPalette.background,
        onBackground: OrbPalette.onBackground,
        surface: OrbPalette.surface,
        onSurface: OrbPalette.onSurface,
        surfaceVariant: OrbPalette.surfaceVariant,
        onSurfaceVariant: OrbPalette.onSurfaceVariant,
        error: OrbPalette.error,
        onError: OrbPalette.onError,
      ),
      textTheme: _textTheme.apply(
        bodyColor: Colors.black,
        displayColor: Colors.black,
        fontFamily: 'SpoqaHanSansNeo',
      ),
    );
  }

  ThemeData get _darkTheme {
    return ThemeData(
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      colorScheme: ColorScheme.dark(
        brightness: Brightness.dark,
        primary: OrbPalette.mainColor,
        onPrimary: OrbPalette.onMainColor,
        secondary: OrbPalette.subColor,
        onSecondary: OrbPalette.onSubColor,
        background: OrbPalette.onBackground,
        onBackground: OrbPalette.background,
        surface: OrbPalette.onSurface,
        onSurface: OrbPalette.surface,
        surfaceVariant: OrbPalette.onSurfaceVariant,
        onSurfaceVariant: OrbPalette.surfaceVariant,
        error: OrbPalette.error,
        onError: OrbPalette.onError,
      ),
      textTheme: _textTheme.apply(
        bodyColor: Colors.white,
        displayColor: Colors.white,
        fontFamily: 'SpoqaHanSansNeo',
      ),
    );
  }
}
