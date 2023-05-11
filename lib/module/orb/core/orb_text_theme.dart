import 'package:flutter/material.dart';

class OrbTextTheme {
  final ColorScheme colorScheme;

  OrbTextTheme({required this.colorScheme});

  final TextTheme _orbTextTheme = const TextTheme(
    displayLarge: TextStyle(fontSize: 72.0, fontWeight: FontWeight.bold),
    displayMedium: TextStyle(fontSize: 36.0, fontStyle: FontStyle.italic),
    displaySmall: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
    titleLarge: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
    titleMedium: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
    titleSmall: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
    bodyLarge: TextStyle(fontSize: 16.0),
    bodyMedium: TextStyle(fontSize: 14.0),
    bodySmall: TextStyle(fontSize: 12.0),
    labelLarge: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
    labelMedium: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
    labelSmall: TextStyle(fontSize: 14.0, fontWeight: FontWeight.bold),
  ).apply(
    fontFamily: 'SpoqaHanSansNeo',
  );

  TextTheme get getTextTheme => _orbTextTheme.apply(
        displayColor: colorScheme.onBackground,
        bodyColor: colorScheme.onBackground,
        decorationColor: colorScheme.onBackground);
}
