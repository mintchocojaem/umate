import 'package:flutter/material.dart';

import 'orb_list_tile.dart';

class OrbListCardTile extends OrbListTile{

  const OrbListCardTile({
    super.key,
    required super.titleText,
    super.contentText,
    super.leading,
    super.trailing,
    super.onTap,
    super.contentAlign
  });

  @override
  Widget build(BuildContext context) {
    ThemeData themeData = Theme.of(context);
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
      decoration: BoxDecoration(
        color: themeData.colorScheme.surfaceVariant,
        borderRadius: BorderRadius.circular(15),
      ),
      child: super.build(context),
    );
  }
}
