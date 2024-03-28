import 'package:danvery/src/design_system/orb/theme/palette.dart';
import 'package:flutter/material.dart';

import '../../theme/orb_theme.dart';

enum OrbTextColorType {
  title,
  body,
  caption,
  disabled,
}

class OrbText extends StatelessWidget {
  final String text;
  final OrbTextColorType colorType;
  final OrbTextTheme textTheme;
  final TextOverflow? overflow;

  const OrbText(
    this.text, {
    super.key,
    required this.textTheme,
    this.colorType = OrbTextColorType.body,
    this.overflow,
  });

  @override
  Widget build(BuildContext context) {
    final bool isLightMode = OrbTheme().isLightMode(context);
    return Text(
      text,
      style: TextStyle(
        color: isLightMode
            ? switch (colorType) {
          OrbTextColorType.title => LightPalette.charcoalBlue,
          OrbTextColorType.body => LightPalette.darkestSlateGray,
          OrbTextColorType.caption => LightPalette.deeperSlateGray,
          OrbTextColorType.disabled => LightPalette.steelGray,
        }
            : switch (colorType) {
          OrbTextColorType.title => DarkPalette.pureWhite,
          OrbTextColorType.body => DarkPalette.silverSand,
          OrbTextColorType.caption => DarkPalette.lightSlateGray,
          OrbTextColorType.disabled => DarkPalette.cadetGray,
        },
        fontFamily: textTheme.fontFamily,
        fontWeight: textTheme.fontWeight.weight,
        fontSize: textTheme.fontSize,
      ),
      overflow: overflow,
    );
  }
}
