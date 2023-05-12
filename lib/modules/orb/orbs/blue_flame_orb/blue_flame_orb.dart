import 'package:danvery/modules/orb/core/orb_palette.dart';
import 'package:danvery/modules/orb/orb.dart';
import 'package:flutter/material.dart';

import 'blue_flame_palette.dart';

export 'package:danvery/modules/orb/orbs/blue_flame_orb/widgets/orb_button.dart';
export 'package:danvery/modules/orb/orbs/blue_flame_orb/widgets/orb_app_bar.dart';
export 'package:danvery/modules/orb/orbs/blue_flame_orb/widgets/dash_board/orb_list_board.dart';

class BlueFlameOrb extends Orb{
  final OrbPalette palette = BlueFlamePalette();

  BlueFlameOrb({required Brightness brightness})
      : super(brightness: brightness){
    lightThemeData = palette.lightThemeData;
    darkThemeData = palette.darkThemeData;
  }


  @override
  void init() {}
}
