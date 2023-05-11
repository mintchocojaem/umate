import 'package:danvery/module/orb/core/orb_text_theme.dart';
import 'package:danvery/module/orb/core/orb_palette.dart';
import 'package:flutter/material.dart';

class BlueFlamePalette implements OrbPalette {

  BlueFlamePalette._internal();
  static final BlueFlamePalette _instance = BlueFlamePalette._internal();
  factory BlueFlamePalette() => _instance;

  static ColorScheme lightColorSchema = const ColorScheme(
    primary: Color(0xFF0D6EFA),
    secondary: Color(0xff0A95FD),
    surface: Color(0xFFEAEAEA),
    surfaceVariant: Color(0xFFD5D5D5),
    surfaceTint: Color(0xFFEFEFEF),
    background: Color(0xFFF5F5F5),
    error: Color(0xFFD50000),
    onPrimary: Color(0xFFFFFFFF),
    onSecondary: Color(0xFF000000),
    onSurface: Color(0xFF242424),
    onSurfaceVariant: Color(0xFF000000),
    onBackground: Color(0xFF000000),
    onError: Color(0xFFFFFFFF),
    brightness: Brightness.light,
  );

  static ColorScheme darkColorSchema = const ColorScheme(
    primary: Color(0xFF0D6EFA),
    secondary: Color(0xff0A95FD),
    surface: Color(0xFF252525),
    surfaceVariant: Color(0xFF404040),
    background: Color(0xFF202020),
    error: Color(0xFFD50000),
    onPrimary: Color(0xFFFFFFFF),
    onSecondary: Color(0xFF000000),
    onSurface: Color(0xFFADADAD),
    onSurfaceVariant: Color(0xFFD5D5D5),
    onBackground: Color(0xFFFFFFFF),
    onError: Color(0xFFFFFFFF),
    brightness: Brightness.dark,
  );

  static final OrbTextTheme lightOrbTextTheme = OrbTextTheme(colorScheme: lightColorSchema);

  @override
  ThemeData lightThemeData = ThemeData(
    scaffoldBackgroundColor: lightColorSchema.surface,
    textTheme: lightOrbTextTheme.getTextTheme,
    colorScheme: lightColorSchema,
    appBarTheme: AppBarTheme(
      backgroundColor: darkColorSchema.surface,
      elevation: 0.0,
      iconTheme: IconThemeData(
        color: lightColorSchema.onSurface,
      ),
      centerTitle: false,
    ),
    filledButtonTheme: FilledButtonThemeData(
      style: ButtonStyle(
        splashFactory: NoSplash.splashFactory,
        padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
          const EdgeInsets.symmetric(vertical: 16.0),
        ),
        textStyle: MaterialStateProperty.all<TextStyle>(
          lightOrbTextTheme.getTextTheme.labelMedium!,
        ),
        shape: MaterialStateProperty.all<OutlinedBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
        ),
      ),
    ),
  );

  static final OrbTextTheme darkOrbTextTheme = OrbTextTheme(colorScheme: darkColorSchema);

  @override
  ThemeData darkThemeData = ThemeData(
    scaffoldBackgroundColor: darkColorSchema.surface,
    textTheme: darkOrbTextTheme.getTextTheme,
    colorScheme: darkColorSchema,
    appBarTheme: AppBarTheme(
      backgroundColor: darkColorSchema.surface,
      elevation: 0.0,
      iconTheme: IconThemeData(
        color: lightColorSchema.onSurface,
      ),
      centerTitle: false,
    ),
    filledButtonTheme: FilledButtonThemeData(
      style: ButtonStyle(
        splashFactory: NoSplash.splashFactory,
        padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
          const EdgeInsets.symmetric(vertical: 16.0),
        ),
        textStyle: MaterialStateProperty.all<TextStyle>(
          darkOrbTextTheme.getTextTheme.labelMedium!,
        ),
        shape: MaterialStateProperty.all<OutlinedBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
        ),
      ),
    ),
  );
}
