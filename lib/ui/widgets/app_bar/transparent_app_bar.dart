import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../utils/theme/app_text_theme.dart';
import '../../../utils/theme/palette.dart';

class TransparentAppBar extends StatelessWidget with PreferredSizeWidget{
  final String title;
  final double height;
  final bool automaticallyImplyLeading;
  final VoidCallback? onPressedLeading;
  final List<Widget>? actions;
  final bool isDarkMode;

  const TransparentAppBar({
    super.key,
    required this.title,
    this.height = 60,
    this.automaticallyImplyLeading = false,
    this.onPressedLeading,
    this.actions,
    required this.isDarkMode,
  });
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return AppBar(
      systemOverlayStyle: isDarkMode ? SystemUiOverlayStyle.light : SystemUiOverlayStyle.dark,
      centerTitle: true,
      toolbarHeight: height,
      backgroundColor: Colors.transparent,
      leading: automaticallyImplyLeading ? IconButton(
        icon: Icon(Icons.arrow_back_ios, color: Palette.black,),
        onPressed: onPressedLeading,
      ) : null,
      title: Text(
        title,
        style: titleStyle.copyWith(color: Palette.black),
      ),
      elevation: 0,
      actions: actions,
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => Size.fromHeight(height);

}
