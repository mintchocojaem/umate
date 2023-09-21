import 'package:flutter/material.dart';

class OrbAppBar extends StatelessWidget implements PreferredSizeWidget {
  final double height = 60;
  final Widget? leading;
  final String title;
  final Widget? trailing;

  const OrbAppBar({
    super.key,
    this.title = "",
    this.leading,
    this.trailing,
  });

  @override
  Widget build(BuildContext context) {
    ThemeData themeData = Theme.of(context);

    return AppBar(
      backgroundColor: themeData.colorScheme.background,
      elevation: 0,
      scrolledUnderElevation: 0,
      leading: leading,
      centerTitle: false,
      title: Text(
        title,
        style: themeData.textTheme.titleMedium?.copyWith(
          fontWeight: FontWeight.w600,
        ),
      ),
      actions: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: trailing ?? const SizedBox(),
        ),
      ],
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(height);
}
