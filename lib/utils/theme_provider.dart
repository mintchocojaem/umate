import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../modules/orb/theme/orb_theme.dart';

final themeProvider = StateProvider<ThemeData>((ref) {
  return OrbTheme(themeMode: ref.watch(themeModeProvider)).currentTheme;
});

final themeModeProvider = StateProvider<ThemeMode>((ref) {
  return ThemeMode.dark;
});