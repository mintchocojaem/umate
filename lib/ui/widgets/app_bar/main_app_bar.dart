import 'package:danvery/utils/theme/palette.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class MainAppBar extends StatelessWidget with PreferredSizeWidget {
  const MainAppBar({
    super.key,
    required this.backGroundColor,
    this.actions,
    this.height = 60,
    this.automaticallyImplyLeading = false,
    this.isWhite = false,
    required this.isDarkMode,
    this.title,
    this.titleStyle
  });

  final TextStyle? titleStyle;
  final String? title;
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
      leadingWidth: 86, //86 - 54 = 32 -> padding right 16, left 16
      leading: isWhite
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
      systemOverlayStyle: isDarkMode
          ? SystemUiOverlayStyle.light
          : SystemUiOverlayStyle.dark,
      centerTitle: true,
      title: title != null ? Text(title!, style: titleStyle,) : const SizedBox(),
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
