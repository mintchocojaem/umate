import 'package:danvery/src/modules/modules.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

part 'theme_mode_provider.dart';

final themeProvider = StateProvider<OrbTheme>(
  (ref) {
    final OrbTheme orbTheme = OrbTheme();
    orbTheme.setThemeMode = ref.watch(themeModeProvider);
    return orbTheme;
  },
);