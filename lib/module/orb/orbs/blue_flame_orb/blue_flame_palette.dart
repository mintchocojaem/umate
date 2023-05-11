import 'package:flutter/material.dart';
import 'package:orb/core/app_text_theme.dart';
import 'package:orb/core/palette.dart';

class BlueFlamePalette implements Palette{

  BlueFlamePalette._internal();
  static final BlueFlamePalette _instance = BlueFlamePalette._internal();
  factory BlueFlamePalette() => _instance;

  @override
  ThemeData lightThemeData = ThemeData(
    colorScheme: const ColorScheme(
      primary: Color(0xFF1E88E5),
      secondary: Color(0xFF00B0FF),
      surface: Color(0xFFFFFFFF),
      background: Color(0xFFE3F2FD),
      error: Color(0xFFD50000),
      onPrimary: Color(0xFFFFFFFF),
      onSecondary: Color(0xFF000000),
      onSurface: Color(0xFF000000),
      onBackground: Color(0xFF000000),
      onError: Color(0xFFFFFFFF),
      brightness: Brightness.light,
    ),
    filledButtonTheme: FilledButtonThemeData(
      style: ButtonStyle(
        splashFactory: NoSplash.splashFactory,
        padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
          const EdgeInsets.symmetric(vertical: 16.0),
        ),
        textStyle: MaterialStateProperty.all<TextStyle>(
          appTextTheme.labelMedium!,
        ),
        shape: MaterialStateProperty.all<OutlinedBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
        ),
        backgroundColor: MaterialStateProperty.resolveWith<Color>(
          (Set<MaterialState> states) {
            if (states.contains(MaterialState.disabled)) {
              return Color(0xFFE0E0E0);
            }
            return Color(0xFF0D6EFA);
          },
        ),
        foregroundColor: MaterialStateProperty.resolveWith<Color>(
          (Set<MaterialState> states) {
            if (states.contains(MaterialState.disabled)) {
              return Color(0xFF000000);
            }
            return Color(0xFFFFFFFF);
          },
        ),
      )
    )

  );

  @override
  ThemeData darkThemeData = ThemeData();

}
