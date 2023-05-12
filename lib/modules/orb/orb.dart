library orb;

import 'package:flutter/material.dart';

import 'orbs/blue_flame_orb/blue_flame_orb.dart';

export 'package:danvery/modules/orb/orbs/blue_flame_orb/blue_flame_orb.dart';

enum OrbType {
  blueFlame,
}

class Orb {
  late ThemeData lightThemeData;
  late ThemeData darkThemeData;
  Brightness brightness;

  Orb({required this.brightness});

  void init() {}

  ThemeData get themeData =>
      brightness == ThemeMode.light ? lightThemeData : darkThemeData;

  ThemeMode get themeMode =>
      brightness == ThemeMode.light ? ThemeMode.light : ThemeMode.dark;

  factory Orb.ofType(OrbType type, {required Brightness brightness}) {
    switch (type) {
      case OrbType.blueFlame:
        return BlueFlameOrb(brightness: brightness);
    }
  }
}
