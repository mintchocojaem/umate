import 'package:flutter/material.dart';

class ModernAppBar extends StatelessWidget implements PreferredSizeWidget {
  final double height = 60;
  final Widget? leading;
  final String title;

  const ModernAppBar({
    super.key,
    required this.title,
    this.leading,
  });

  @override
  Widget build(BuildContext context) {
    ThemeData themeData = Theme.of(context);

    return AppBar(
      title: Row(
        children: [
          if (leading != null) leading!,
          const SizedBox(
            width: 8,
          ),
          Text(
            title,
            style: themeData.textTheme.titleLarge,
          ),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(height);

}
