import 'package:flutter/material.dart';

import 'orb_tile.dart';

class OrbCardTile extends OrbTile{

  const OrbCardTile({
    super.key,
    required super.title,
    super.body,
    super.leading,
    super.trailing,
    super.onTap,
  });

  @override
  Widget build(BuildContext context) {
    ThemeData themeData = Theme.of(context);
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
      decoration: BoxDecoration(
        color: themeData.colorScheme.onBackground,
        borderRadius: BorderRadius.circular(15),
      ),
      child: super.build(context),
    );
  }
}
