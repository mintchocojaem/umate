import 'package:danvery/app/ui/theme/app_text_theme.dart';
import 'package:flutter/material.dart';

class MainAppBar extends StatelessWidget with PreferredSizeWidget {
  const MainAppBar({
    super.key,
    required this.title,
    required this.titleColor,
    required this.backGroundColor,
    this.actions,
    this.height = 60,
    this.automaticallyImplyLeading = false,
    this.isWhite = false,
  });

  final String title;
  final Color titleColor;
  final Color backGroundColor;
  final List<Widget>? actions;
  final double height;
  final bool automaticallyImplyLeading;
  final bool isWhite;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return AppBar(
      centerTitle: false,
      title: isWhite
          ? Image.asset(
              'assets/icons/danvery/danvery_white.png',
              width: 54,
              height: 54,
            )
          : Image.asset(
              'assets/icons/danvery/danvery_blue.png',
              width: 54,
              height: 54,
            ),
      backgroundColor: backGroundColor,
      actions: [
        Padding(
          padding: const EdgeInsets.only(right: 16, left: 16),
          child: Center(
            child: Row(
              children: actions ?? [],
            ),
          ),
        )
      ],
      elevation: 0,
      automaticallyImplyLeading: automaticallyImplyLeading,
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => Size.fromHeight(height);
}
