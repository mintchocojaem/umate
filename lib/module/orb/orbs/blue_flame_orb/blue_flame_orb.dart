import 'package:danvery/module/orb/core/orb_palette.dart';
import 'package:danvery/module/orb/orb.dart';
import 'package:flutter/material.dart';

import 'blue_flame_palette.dart';

export 'package:danvery/module/orb/orbs/blue_flame_orb/widgets/orb_button.dart';
export 'package:danvery/module/orb/orbs/blue_flame_orb/widgets/orb_app_bar.dart';

class BlueFlameOrb extends Orb {
  final OrbPalette palette = BlueFlamePalette();

  BlueFlameOrb({
    required Brightness brightness,
  }) : super(brightness: brightness) {
    lightThemeData = palette.lightThemeData;
    darkThemeData = palette.darkThemeData;
  }

  @override
  void init() {

  }

}
