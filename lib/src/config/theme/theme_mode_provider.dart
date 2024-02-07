import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final themeModeProvider = StateProvider<ThemeMode>(
  (ref) {
    const ThemeMode themeMode = ThemeMode.light;
    return themeMode;
  },
);
