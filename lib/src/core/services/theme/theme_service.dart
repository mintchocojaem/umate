import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../design_system/orb/theme/orb_theme.dart';

final themeServiceProvider =
    NotifierProvider<OrbThemeServiceViewModel, ThemeData>(() {
  final orbThemeService = OrbTheme();
  return OrbThemeServiceViewModel(orbThemeService: orbThemeService);
});

class OrbThemeServiceViewModel extends Notifier<ThemeData> {
  final OrbTheme _orbThemeService;

  OrbThemeServiceViewModel({
    required OrbTheme orbThemeService,
  }) : _orbThemeService = orbThemeService;

  @override
  ThemeData build() {
    // TODO: implement build
    return _orbThemeService.getThemeMode();
  }

  void setThemeMode(ThemeMode themeMode) {
    _orbThemeService.setThemeMode(themeMode);
    state = _orbThemeService.getThemeMode();
  }

  ThemeData getThemeMode() {
    return _orbThemeService.getThemeMode();
  }
}
