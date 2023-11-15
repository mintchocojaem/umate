import 'package:flutter/material.dart';

import 'orb_list_tile.dart';

class OrbListCardTile extends OrbListTile {
  final Color? backgroundColor;

  const OrbListCardTile({
    super.key,
    required super.titleText,
    super.contentText,
    super.leading,
    super.trailing,
    super.onTap,
    super.contentAlign,
    super.tileTextStyle,
    super.boldTitleText,
    this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    ThemeData themeData = Theme.of(context);
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
      decoration: BoxDecoration(
        color: backgroundColor ?? themeData.colorScheme.surface,
        borderRadius: BorderRadius.circular(15),
      ),
      child: super.build(context),
    );
  }
}
