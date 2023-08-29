import 'package:flutter/material.dart';
import 'orb_palette.dart';

class OrbTheme {
  final ThemeData dark = ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,
    textTheme: const TextTheme().apply(fontFamily: 'SpoqaHanSansNeo'),
    splashColor: Colors.transparent,
    highlightColor: Colors.transparent,
    colorScheme: const ColorScheme.dark(
      primary: OrbPalette.blue,
      onPrimary: OrbPalette.white,
      secondary: OrbPalette.lightBlue,
      onSecondary: OrbPalette.white,
      surfaceVariant: OrbPalette.black,
    ),
  );

  final ThemeData light = ThemeData(
    useMaterial3: true,
    brightness: Brightness.light,
    textTheme: const TextTheme().apply(fontFamily: 'SpoqaHanSansNeo'),
    splashColor: Colors.transparent,
    highlightColor: Colors.transparent,
    colorScheme: const ColorScheme.light(
      primary: OrbPalette.blue,
      onPrimary: OrbPalette.white,
      secondary: OrbPalette.lightBlue,
      onSecondary: OrbPalette.white,
      surfaceVariant: OrbPalette.white,
    ),
  );
}
