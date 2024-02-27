import 'package:flutter/material.dart';

import 'orb_list_tile.dart';

enum OrbListCardTileStyle {
  surface,
  surfaceVariant,
  background,
}

class OrbListCardTile extends OrbListTile {

  const OrbListCardTile({
    super.key,
    required super.titleText,
    super.titleTextColor,
    super.contentText,
    super.leading,
    super.trailing,
    super.onTap,
    super.tileTextStyle,
    super.boldTitleText,
    this.style = OrbListCardTileStyle.surface,
  });

  final OrbListCardTileStyle style;

  @override
  // TODO: implement tileTextStyle
  TileTextStyle? get tileTextStyle => TileTextStyle.large;

  @override
  Widget build(BuildContext context) {
    ThemeData themeData = Theme.of(context);
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
      decoration: BoxDecoration(
        color: switch(style) {
          OrbListCardTileStyle.surface => themeData.colorScheme.surface,
          OrbListCardTileStyle.surfaceVariant => themeData.colorScheme.surfaceVariant,
          OrbListCardTileStyle.background => themeData.colorScheme.background,
        },
        borderRadius: BorderRadius.circular(15),
      ),
      child: super.build(context),
    );
  }
}
