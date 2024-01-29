import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../modules/modules.dart';
import '../configs.dart';

final themeProvider = StateProvider<OrbTheme>(
  (ref) {
    final OrbTheme orbTheme = OrbTheme();
    orbTheme.setThemeMode = ref.watch(themeModeProvider);
    return orbTheme;
  },
);
