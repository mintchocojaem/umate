import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../core.dart';

final themeProvider = StateProvider<ThemeData>(
  (ref) {
    return OrbTheme(themeMode: ThemeMode.dark).currentTheme;
  },
);
