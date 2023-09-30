import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class OrbAppBar extends StatelessWidget implements PreferredSizeWidget {

  final double height = 60;
  final Widget? leading;
  final String title;
  final TextStyle? titleStyle;
  final Widget? trailing;
  final bool centerTitle;
  final bool showLoadingIndicator;

  const OrbAppBar({
    super.key,
    this.title = "",
    this.titleStyle,
    this.leading,
    this.trailing,
    this.centerTitle = false,
    this.showLoadingIndicator = false,
  });

  @override
  Widget build(BuildContext context) {
    ThemeData themeData = Theme.of(context);
    return AppBar(
      backgroundColor: themeData.colorScheme.background,
      elevation: 0,
      scrolledUnderElevation: 0,
      leading: leading,
      centerTitle: centerTitle,
      title: Text(
        title,
        style: titleStyle ?? themeData.textTheme.titleSmall?.copyWith(
          fontWeight: FontWeight.w600,
        ),
      ),
      actions: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: trailing ?? const SizedBox(),
        ),
      ],
      bottom: showLoadingIndicator ? PreferredSize(
        preferredSize: const Size.fromHeight(2),
        child: Shimmer.fromColors(
          baseColor: themeData.colorScheme.surface,
          highlightColor: themeData.colorScheme.primary,
          child: LinearProgressIndicator(
            minHeight: 2,
            value: 1,
            color: themeData.colorScheme.primary,
          ),
        ),
      ) : null,
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(height);

}
