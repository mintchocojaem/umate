import 'package:danvery/app/ui/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

final ThemeData appThemeData = ThemeData(
  brightness: Brightness.light,
  textTheme: GoogleFonts.notoSansTextTheme(), //폰트 깨지는거 해결해야함
  bottomNavigationBarTheme: const BottomNavigationBarThemeData(
    unselectedItemColor: dark,
    selectedItemColor: dark,
  ),
  iconTheme: const IconThemeData(
    color: dark,
  ),
);
