import 'package:danvery/core/theme/palette.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../core/theme/app_text_theme.dart';

class TransparentAppBar extends StatelessWidget with PreferredSizeWidget{
  final String title;
  final double height;
  final bool automaticallyImplyLeading;
  final VoidCallback? onPressedLeading;
  final List<Widget>? actions;
  final bool isDarkMode;
  final bool isCenterTitle;
  final TextStyle? titleTextStyle;

  const TransparentAppBar({
    super.key,
    required this.title,
    this.height = 60,
    this.automaticallyImplyLeading = false,
    this.onPressedLeading,
    this.actions,
    required this.isDarkMode,
    this.isCenterTitle = true,
    this.titleTextStyle,
  });
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return AppBar(
      systemOverlayStyle: isDarkMode ? SystemUiOverlayStyle.light : SystemUiOverlayStyle.dark,
      centerTitle: isCenterTitle,
      toolbarHeight: height,
      backgroundColor: Colors.transparent,
      leading: automaticallyImplyLeading ? IconButton(
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
        icon: Icon(Icons.arrow_back_ios, color: Palette.black,),
        onPressed: onPressedLeading,
      ) : null,
      title: Text(
        title,
        style: titleTextStyle ?? smallTitleStyle.copyWith(color: Palette.black,fontWeight: FontWeight.normal),
      ),
      elevation: 0,
      actions: actions,
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => Size.fromHeight(height);

}
