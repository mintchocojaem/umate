import 'package:danvery/utils/theme/app_text_theme.dart';
import 'package:danvery/utils/theme/palette.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class SearchAppBar extends StatelessWidget with PreferredSizeWidget {
  final Color backGroundColor;
  final double height;
  final bool automaticallyImplyLeading;
  final bool isDarkMode;
  final String hint;
  final VoidCallback? onPressedLeading;
  final TextEditingController? controller;

  const SearchAppBar({
    super.key,
    required this.backGroundColor,
    this.height = 60,
    this.automaticallyImplyLeading = true,
    required this.isDarkMode,
    required this.hint,
    this.onPressedLeading,
    this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0,
      systemOverlayStyle:
          isDarkMode ? SystemUiOverlayStyle.light : SystemUiOverlayStyle.dark,
      backgroundColor: backGroundColor,
      centerTitle: false,
      title: TextField(
        controller: controller,
        textAlignVertical: TextAlignVertical.center,
        cursorColor: Palette.grey,
        maxLines: 1,
        style: regularStyle.copyWith(color: Palette.darkGrey),
        decoration: InputDecoration(
            filled: true,
            fillColor: Palette.lightGrey,
            hintText: hint,
            hintStyle: regularStyle.copyWith(color: Palette.grey),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5),
              borderSide: BorderSide.none,
            ),
            isDense: true,
            contentPadding:
                const EdgeInsets.only(left: 16, top: 12, bottom: 12, right: 16),
            suffixIcon: Icon(
              Icons.cancel,
              color: Palette.grey,
            )),
      ),
      leading: automaticallyImplyLeading
          ? Padding(
              padding: const EdgeInsets.only(left: 16),
              child: IconButton(
                icon: Icon(
                  Icons.arrow_back_ios,
                  color: Palette.darkGrey,
                ),
                onPressed: onPressedLeading,
              ),
            )
          : null,
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => Size.fromHeight(height);
}
