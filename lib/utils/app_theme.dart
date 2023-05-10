import 'package:danvery/utils/app_text_theme.dart';
import 'package:danvery/utils/palette.dart';
import 'package:flutter/material.dart';

class AppTheme{
  AppTheme._internal();

  static final AppTheme _instance = AppTheme._internal();

  factory AppTheme() => _instance;

  final ThemeData lightThemeData = ThemeData(
    brightness: Brightness.light,
    textTheme: appTextTheme,
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
              return Palette.grey;
            }
            return Palette.blue;
          },
        ),
        foregroundColor: MaterialStateProperty.resolveWith<Color>(
          (Set<MaterialState> states) {
            if (states.contains(MaterialState.disabled)) {
              return Colors.white;
            }
            return Colors.white;
          },
        ),
      )
    )
  );

  final ThemeData darkThemeData = ThemeData(
    brightness: Brightness.dark,
    textTheme: appTextTheme,
    buttonTheme: ButtonThemeData(
      buttonColor: Palette.blue,
      disabledColor: Palette.grey,
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
                  return Palette.grey;
                }
                return Palette.blue;
              },
            ),
            foregroundColor: MaterialStateProperty.resolveWith<Color>(
                  (Set<MaterialState> states) {
                if (states.contains(MaterialState.disabled)) {
                  return Colors.white;
                }
                return Colors.white;
              },
            ),
          )
      )
  );
}
