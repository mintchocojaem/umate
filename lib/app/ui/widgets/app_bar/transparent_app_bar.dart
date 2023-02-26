import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../theme/app_colors.dart';
import '../../theme/app_text_theme.dart';

class TransparentAppBar extends StatelessWidget with PreferredSizeWidget{
  final String title;
  final double height;
  final bool automaticallyImplyLeading;
  final VoidCallback? onPressedLeading;
  const TransparentAppBar({
    super.key,
    required this.title,
    this.height = 80,
    this.automaticallyImplyLeading = false,
    this.onPressedLeading,
  });
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return AppBar(
      toolbarHeight: height,
      backgroundColor: transparent,
      leading: automaticallyImplyLeading ? IconButton(
        icon: const Icon(Icons.arrow_back_ios, color: grey,),
        onPressed: onPressedLeading,
      ) : null,
      title: Text(
        title,
        style: titleStyle.copyWith(color: grey),
      ),
      elevation: 0,
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => Size.fromHeight(height);

}
