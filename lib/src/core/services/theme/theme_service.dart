import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../design_system/orb/theme/orb_theme.dart';

final themeServiceProvider = Provider<OrbTheme>(
  (ref) => OrbTheme(),
);
