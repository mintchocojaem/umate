import 'package:danvery/app/ui/theme/app_colors.dart';
import 'package:flutter/material.dart';

final ThemeData appThemeData = ThemeData(
  brightness: Brightness.light,
  bottomNavigationBarTheme: const BottomNavigationBarThemeData(
    unselectedItemColor: dark,
    selectedItemColor: dark,
  ),
  iconTheme: const IconThemeData(
    color: dark,
  ),
);
