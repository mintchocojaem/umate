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
    ).apply(fontFamily: 'SpoqaHanSansNeo'),
    brightness: Brightness.light,
    colorScheme: const ColorScheme.light(
      //메인 색상
      primary: OrbPalette.blue,
      //메인 색상의 글자 색상
      onPrimary: OrbPalette.white,
      //보조 색상
      secondary: OrbPalette.lightBlue,
      //보조 색상의 글자 색상
      onSecondary: OrbPalette.white,
      //카드, 컨테이너 등의 배경색
      surface: OrbPalette.darkWhite,
      //카드, 컨테이너 등의 글자 색상
      onSurface: OrbPalette.grey,
      //카드, 컨테이너 등의 보조 색상
      surfaceVariant: OrbPalette.brightGrey,
      //배경, 앱바색
      background: OrbPalette.white,
      //배경의 글자 색상
      onBackground: OrbPalette.darkGrey,
    ),
  );

  final ThemeData _dark = ThemeData(
    useMaterial3: true,
    splashColor: Colors.transparent,
    highlightColor: Colors.transparent,
    textTheme: const TextTheme(
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
    ).apply(fontFamily: 'SpoqaHanSansNeo'),
    brightness: Brightness.dark,
    colorScheme: const ColorScheme.dark(
      //메인 색상
      primary: OrbPalette.blue,
      //메인 색상의 글자 색상
      onPrimary: OrbPalette.white,
      //보조 색상
      secondary: OrbPalette.lightBlue,
      //보조 색상의 글자 색상
      onSecondary: OrbPalette.white,
      //카드, 컨테이너 등의 배경색
      surface: OrbPalette.darkGrey,
      //카드, 컨테이너 등의 글자 색상
      onSurface: OrbPalette.darkWhite,
      //카드, 컨테이너 등의 보조 색상
      surfaceVariant: OrbPalette.grey,
      //배경, 앱바색
      background: OrbPalette.black,
      //배경의 글자 색상
      onBackground: OrbPalette.darkGrey,
    ),
  );

}
