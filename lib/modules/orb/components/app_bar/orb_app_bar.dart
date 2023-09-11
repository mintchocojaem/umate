import 'package:flutter/material.dart';

class OrbAppBar extends StatelessWidget implements PreferredSizeWidget {
  final double height = 60;
  final Widget? leading;
  final String? title;

  const OrbAppBar({
    super.key,
    this.title,
    this.leading,
  });

  @override
  Widget build(BuildContext context) {
    ThemeData themeData = Theme.of(context);

    return AppBar(
      scrolledUnderElevation: 0,
      centerTitle: true,
      title:  Text(
        title ?? '',
        style: themeData.textTheme.titleLarge,
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(height);

}
