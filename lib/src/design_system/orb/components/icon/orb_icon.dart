import 'package:flutter/cupertino.dart';

import '../../orb.dart';

enum OrbIconSize {
  small,
  regular,
  medium,
  large,
}

class OrbIcon extends StatelessWidget {
  final IconData icon;
  final OrbIconSize size;
  final Color? color;

  const OrbIcon(
    this.icon, {
    super.key,
    this.size = OrbIconSize.regular,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    final themeData = OrbThemeData.of(context);
    final palette = themeData.palette;
    return Icon(
      icon,
      size: switch (size) {
        OrbIconSize.small => 16,
        OrbIconSize.regular => 24,
        OrbIconSize.medium => 32,
        OrbIconSize.large => 40,
      },
      color: color ?? palette.surface,
    );
  }
}
