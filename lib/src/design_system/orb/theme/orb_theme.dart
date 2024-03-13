import 'package:flutter/material.dart';

class OrbTheme{

  final primaryColor = const Color(0xFF137eff);
  final onPrimaryColor = const Color(0xFFFFFFFF);
  final secondaryColor = const Color(0xFF3d94ff);
  final onSecondaryColor = const Color(0xFFFFFFFF);
  final surfaceColor = const Color(0xFFf2f2f2);
  final onSurfaceColor = const Color(0xFF222222);
  final backgroundColor = const Color(0xFFFFFFFF);
  final onBackgroundColor = const Color(0xFF151515);
  final surfaceVariantColor = const Color(0xFFd9d9d9);
  final onSurfaceVariantColor = const Color(0xFF323232);
  final errorColor = const Color(0xFFff5151);
  final onErrorColor = const Color(0xFFFFFFFF);

  static const TextTheme textTheme = TextTheme(
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

  ThemeMode _themeMode = ThemeMode.system;

  void setThemeMode(ThemeMode themeMode) {
    _themeMode = themeMode;
  }

  ThemeData getThemeMode() {
    switch (_themeMode) {
      case ThemeMode.system:
        final brightness =
            WidgetsBinding.instance.platformDispatcher.platformBrightness;
        return brightness == Brightness.dark
            ? _darkTheme
            : _lightTheme;
      case ThemeMode.light:
        return _lightTheme;
      case ThemeMode.dark:
        return _darkTheme;
    }
  }

  ThemeData get _lightTheme {
    return ThemeData(
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      colorScheme: ColorScheme.light(
        brightness: Brightness.light,
        primary: primaryColor,
        onPrimary: onPrimaryColor,
        secondary: secondaryColor,
        onSecondary: onSecondaryColor,
        background: backgroundColor,
        onBackground: onBackgroundColor,
        surface: surfaceColor,
        onSurface: onSurfaceColor,
        surfaceVariant: surfaceVariantColor,
        onSurfaceVariant: onSurfaceVariantColor,
        error: errorColor,
        onError: onErrorColor,
      ),
      textTheme: textTheme.apply(
        bodyColor: onSurfaceVariantColor,
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
        primary: primaryColor,
        onPrimary: onPrimaryColor,
        secondary: secondaryColor,
        onSecondary: onSecondaryColor,
        background: onSurfaceColor,
        onBackground: surfaceColor,
        surface: onBackgroundColor,
        onSurface: backgroundColor,
        surfaceVariant: onSurfaceVariantColor,
        onSurfaceVariant: surfaceVariantColor,
        error: errorColor,
        onError: onErrorColor,
      ),
      textTheme: OrbTheme.textTheme.apply(
        bodyColor: surfaceVariantColor,
        fontFamily: 'SpoqaHanSansNeo',
      ),
    );
  }
}
