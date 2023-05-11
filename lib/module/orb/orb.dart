library orb;

import 'package:flutter/material.dart';

import 'orbs/blue_flame_orb/blue_flame_orb.dart';

export 'package:danvery/module/orb/orbs/blue_flame_orb/blue_flame_orb.dart';

enum OrbType{
  blueFlame,
}

class Orb {

  Orb({required this.brightness});

  late ThemeData lightThemeData;
  late ThemeData darkThemeData;
  Brightness brightness;

  void init(){

  }

  ThemeData getOrbMode() {
    return brightness == Brightness.light ? lightThemeData : darkThemeData;
  }

  factory Orb.ofType(OrbType type, {required Brightness brightness}) {
    switch (type) {
      case OrbType.blueFlame:
        return BlueFlameOrb(brightness: brightness);
    }
  }

}
