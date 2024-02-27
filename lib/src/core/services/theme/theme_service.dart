import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../design_system/orb/theme/theme.dart';

final themeServiceProvider = NotifierProvider<ThemeServiceNotifier, OrbTheme>(() {
  return ThemeServiceNotifier();
});

class ThemeServiceNotifier extends Notifier<OrbTheme> {
  @override
  OrbTheme build() {
    // TODO: implement build
    final OrbTheme orbTheme = OrbTheme();
    return orbTheme;
  }

  void setThemeMode(ThemeMode themeMode) {
    state = state..setThemeMode(themeMode);
  }
}
