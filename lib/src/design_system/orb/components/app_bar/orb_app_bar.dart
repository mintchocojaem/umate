import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../../orb.dart';

class OrbAppBar extends StatelessWidget implements PreferredSizeWidget {
  final Widget? leading;
  final String title;
  final Widget? trailing;
  final bool centerTitle;
  final Color? backgroundColor;
  final bool isLoading;
  final Color? titleColor;

  const OrbAppBar({
    super.key,
    this.title = "",
    this.leading,
    this.trailing,
    this.centerTitle = false,
    this.isLoading = false,
    this.backgroundColor,
    this.titleColor,
  });

  @override
  Widget build(BuildContext context) {
    final themeData = OrbThemeData.of(context);
    final palette = themeData.palette;
    return AppBar(
      backgroundColor: backgroundColor ?? palette.background,
      elevation: 0,
      scrolledUnderElevation: 0,
      leading: leading ??
          (ModalRoute.of(context)?.canPop ?? false
              ? IconButton(
                  icon: OrbIcon(
                    Icons.arrow_back_ios,
                  ),
                  onPressed: () async {
                    FocusManager.instance.primaryFocus?.unfocus();
                    await Future.delayed(const Duration(milliseconds: 100));
                    if (context.mounted) {
                      Navigator.of(context).pop();
                    }
                  },
                )
              : null),
      centerTitle: centerTitle,
      title: OrbText(
        title,
        type: OrbTextType.titleMedium,
        color: titleColor,
      ),
      actions: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: trailing ?? const SizedBox(),
        ),
      ],
      bottom: isLoading
          ? PreferredSize(
              preferredSize: const Size.fromHeight(2),
              child: Shimmer.fromColors(
                baseColor: palette.onPrimary,
                highlightColor: palette.primary,
                child: LinearProgressIndicator(
                  minHeight: 2,
                  value: 1,
                  color: palette.primary,
                ),
              ),
            )
          : null,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(60);
}
