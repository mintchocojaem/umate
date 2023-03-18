import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class MainAppBar extends StatelessWidget with PreferredSizeWidget {
  const MainAppBar({
    super.key,
    required this.titleColor,
    required this.backGroundColor,
    this.actions,
    this.height = 60,
    this.automaticallyImplyLeading = false,
    this.isWhite = false,
    required this.isDarkMode,
  });

  final Color titleColor;
  final Color backGroundColor;
  final List<Widget>? actions;
  final double height;
  final bool automaticallyImplyLeading;
  final bool isWhite;
  final bool isDarkMode;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return AppBar(
      systemOverlayStyle: isDarkMode
          ? SystemUiOverlayStyle.light
          : SystemUiOverlayStyle.dark,
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
