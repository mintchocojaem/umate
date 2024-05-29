import 'package:flutter/material.dart';

import '../../orb.dart';

enum OrbTextType {
  titleLarge,
  titleMedium,
  titleSmall,
  bodyLarge,
  bodyMedium,
  bodySmall,
}

class OrbText extends StatelessWidget {
  final String text;
  final OrbTextType type;
  final OrbFontWeight fontWeight;
  final TextOverflow? overflow;
  final double? height;
  final int? maxLines;
  final Color? color;
  final TextAlign? textAlign;

  const OrbText(
    this.text, {
    super.key,
    this.type = OrbTextType.bodyMedium,
    this.fontWeight = OrbFontWeight.regular,
    this.overflow,
    this.height,
    this.maxLines,
    this.color,
    this.textAlign,
  });

  @override
  Widget build(BuildContext context) {
    final textTheme = OrbThemeData.of(context).textTheme;
    return Text(
      text,
      style: switch (type) {
        OrbTextType.titleLarge => textTheme.titleLarge.copyWith(
            fontWeight: fontWeight.weight,
            height: height,
            color: color,
          ),
        OrbTextType.titleMedium => textTheme.titleMedium.copyWith(
            fontWeight: fontWeight.weight,
            height: height,
            color: color,
          ),
        OrbTextType.titleSmall => textTheme.titleSmall.copyWith(
            fontWeight: fontWeight.weight,
            height: height,
            color: color,
          ),
        OrbTextType.bodyLarge => textTheme.bodyLarge.copyWith(
            fontWeight: fontWeight.weight,
            height: height,
            color: color,
          ),
        OrbTextType.bodyMedium => textTheme.bodyMedium.copyWith(
            fontWeight: fontWeight.weight,
            height: height,
            color: color,
          ),
        OrbTextType.bodySmall => textTheme.bodySmall.copyWith(
            fontWeight: fontWeight.weight,
            height: height,
            color: color,
          ),
      },
      overflow: overflow,
      maxLines: maxLines,
      textAlign: textAlign,
    );
  }
}
