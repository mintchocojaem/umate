import 'package:danvery/core/theme/palette.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../core/theme/app_text_theme.dart';

class TransparentAppBar extends StatelessWidget with PreferredSizeWidget{
  final String title;
  final Color? backgroundColor;
  final double height;
  final bool automaticallyImplyLeading;
  final Color? leadingColor;
  final VoidCallback? onPressedLeading;
  final List<Widget>? actions;
  final bool isDarkMode;
  final bool isCenterTitle;
  final Color? titleColor;

  const TransparentAppBar({
    super.key,
    required this.title,
    this.height = 60,
    this.automaticallyImplyLeading = false,
    this.onPressedLeading,
    this.leadingColor,
    this.actions,
    required this.isDarkMode,
    this.isCenterTitle = true,
    this.titleColor,
    this.backgroundColor = Colors.transparent
  });
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return AppBar(
      systemOverlayStyle: isDarkMode ? SystemUiOverlayStyle.light : SystemUiOverlayStyle.dark,
      centerTitle: isCenterTitle,
      toolbarHeight: height,
      backgroundColor: backgroundColor,
      leading: automaticallyImplyLeading ? IconButton(
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
        icon: Icon(Icons.arrow_back_ios, color: leadingColor ?? Palette.black,),
        onPressed: onPressedLeading,
      ) : null,
      title: Text(
        title,
        style: smallTitleStyle.copyWith(color: titleColor ?? Palette.black,fontWeight: FontWeight.normal),
      ),
      elevation: 0,
      actions: actions,
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => Size.fromHeight(height);

}
