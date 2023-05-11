import 'package:flutter/material.dart';

class AppTheme{
  AppTheme._internal();

  static final AppTheme _instance = AppTheme._internal();

  factory AppTheme() => _instance;

  final ThemeData lightThemeData = ThemeData(
    brightness: Brightness.light,
  );

  final ThemeData darkThemeData = ThemeData(
    brightness: Brightness.dark,
  );
}
