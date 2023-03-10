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
  });

  final String title;
  final Color titleColor;
  final Color backGroundColor;
  final List<Widget>? actions;
  final double height;
  final bool automaticallyImplyLeading;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return AppBar(
      centerTitle: false,
      title: Text(
        title,
        style: titleStyle.copyWith(color: titleColor),
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
