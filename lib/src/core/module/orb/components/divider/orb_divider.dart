import 'package:flutter/material.dart';

class OrbDivider extends StatelessWidget {
  const OrbDivider({super.key});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    final ThemeData themeData = Theme.of(context);
    return Divider(
      thickness: 1,
      color: themeData.colorScheme.surfaceVariant,
    );
  }

}
