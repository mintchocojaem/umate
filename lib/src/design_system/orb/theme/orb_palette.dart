import 'package:flutter/foundation.dart';
import 'package:flutter/painting.dart';

abstract class OrbPalette{
  final Color primary;
  final Color onPrimary;
  final Color secondary;
  final Color onSecondary;
  final Color error;
  final Color onError;
  final Color errorContainer;
  final Color background;
  final Color onBackground;
  final Color surfaceBright;
  final Color surface;
  final Color surfaceDim;
  final Color onSurface;
  final Color shadow;
  final Color outline;

  const OrbPalette({
    required this.primary,
    required this.onPrimary,
    required this.secondary,
    required this.onSecondary,
    required this.error,
    required this.onError,
    required this.errorContainer,
    required this.background,
    required this.onBackground,
    required this.surfaceBright,
    required this.surface,
    required this.surfaceDim,
    required this.onSurface,
    required this.shadow,
    required this.outline,
  });
}

@immutable
class OrbLightPalette implements OrbPalette {

  static const OrbLightPalette _instance = OrbLightPalette._();
  factory OrbLightPalette() => _instance;
  const OrbLightPalette._();

  @override
  final Color primary = const Color(0xFF5062E2);
  @override
  final Color onPrimary = const Color(0xFFFFFFFF);
  @override
  final Color secondary = const Color(0xFF7280E8);
  @override
  final Color onSecondary = const Color(0xFFFFFFFF);
  @override
  final Color error = const Color(0xFFDE5257);
  @override
  final Color onError = const Color(0xFFFFFFFF);
  @override
  final Color errorContainer = const Color(0xFFFDEEEE);
  @override
  final Color background = const Color(0xFFFFFFFF);
  @override
  final Color onBackground = const Color(0xFF000000);
  @override
  final Color surfaceBright = const Color(0xFFF3F4F6);
  @override
  final Color surface = const Color(0xFF8D969F);
  @override
  final Color surfaceDim = const Color(0xFF636E7E);
  @override
  final Color onSurface = const Color(0xFFFFFFFF);
  @override
  final Color shadow = const Color(0xFF1A1E27);
  @override
  final Color outline = const Color(0xFFE0E0E0);
}

@immutable
class OrbDarkPalette implements OrbPalette {

  static const OrbDarkPalette _instance = OrbDarkPalette._();
  factory OrbDarkPalette() => _instance;
  const OrbDarkPalette._();

  @override
  final Color primary = const Color(0xFF5062E2);
  @override
  final Color onPrimary = const Color(0xFFFFFFFF);
  @override
  final Color secondary = const Color(0xFF7280E8);
  @override
  final Color onSecondary = const Color(0xFFFFFFFF);
  @override
  final Color error = const Color(0xFFDE5257);
  @override
  final Color onError = const Color(0xFFFFFFFF);
  @override
  final Color errorContainer = const Color(0xFF372529);
  @override
  final Color background = const Color(0xFF18171D);
  @override
  final Color onBackground = const Color(0xFFFFFFFF);
  @override
  final Color surfaceBright = const Color(0xFFB2B8C0);
  @override
  final Color surface = const Color(0xFF8D969F);
  @override
  final Color surfaceDim = const Color(0xFF636E7E);
  @override
  final Color onSurface = const Color(0xFFFFFFFF);
  @override
  final Color shadow = const Color(0xFF1A1E27);
  @override
  final Color outline = const Color(0xFF363D4C);
}
