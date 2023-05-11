import 'package:flutter/material.dart';
import 'package:orb/core/palette.dart';
import 'package:orb/orb.dart';
import 'package:orb/orbs/blue_flame_orb/blue_flame_palette.dart';

class BlueFlameOrb implements Orb {

  final BuildContext context;

  BlueFlameOrb(this.context);

  @override
  Palette palette = BlueFlamePalette();

  @override
  late ThemeData themeData;

  @override
  void init() {
    // TODO: implement init
    themeData = Theme.of(context).brightness == Brightness.light
        ? palette.lightThemeData
        : palette.darkThemeData;
  }


}
