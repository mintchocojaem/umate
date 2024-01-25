part of 'theme_provider.dart';

final themeModeProvider = StateProvider<ThemeMode>(
      (ref) {
    const ThemeMode themeMode = ThemeMode.system;
    return themeMode;
  },
);