import 'package:flutter/material.dart';

import '../../orb.dart';

class OrbCircularProgressIndicator extends StatelessWidget {

  const OrbCircularProgressIndicator({
    super.key,
    this.value,
    this.valueColor,
  });

  final double? value;
  final Color? valueColor;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    final themeData = OrbThemeData.of(context);
    final palette = themeData.palette;
    return CircularProgressIndicator(
      value: value,
      valueColor: AlwaysStoppedAnimation<Color>(
        valueColor ?? palette.primary,
      ),
    );
  }
}
