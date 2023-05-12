import 'package:flutter/material.dart';

class OrbAppbar extends StatelessWidget with PreferredSizeWidget{

  final double height = 56.0;
  final Widget? leading;

  OrbAppbar({super.key, this.leading});

  @override
  Widget build(BuildContext context) {
    ThemeData themeData = Theme.of(context);

    // TODO: implement build
    return AppBar(
      backgroundColor: themeData.colorScheme.background,
      title: Row(
        children: [
          if (leading != null) leading!,
          const SizedBox(width: 8,),
          Text(
            'Danvery',
            style: themeData.textTheme.titleMedium,
          ),
        ],
      ),
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => Size.fromHeight(height);

}
