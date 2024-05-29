import 'package:flutter/material.dart';

import '../../orb.dart';

class OrbDivider extends StatelessWidget{

  const OrbDivider({super.key});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    final themeData = OrbThemeData.of(context);
    final palette = themeData.palette;
    return Divider(
      height: 1,
      thickness: 1,
      color: palette.outline,
    );
  }

}