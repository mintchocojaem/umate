import 'package:flutter/material.dart';

import '../../orb.dart';

class OrbBoardContainer extends StatelessWidget {
  final Widget? title;
  final Widget? info;
  final Color? infoColor;
  final Widget? child;
  final Decoration? decoration;
  final Widget? trailing;
  final VoidCallback? onTap;
  final BorderRadius? borderRadius;
  final Color? backgroundColor;

  const OrbBoardContainer({
    super.key,
    this.title,
    this.info,
    this.infoColor,
    this.decoration,
    this.trailing,
    this.child,
    this.onTap,
    this.borderRadius,
    this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    final theme = OrbTheme.of(context);
    return AnimatedSize(
      alignment: Alignment.topCenter,
      duration: const Duration(milliseconds: 500),
      curve: Curves.fastOutSlowIn,
      reverseDuration: const Duration(milliseconds: 500),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: decoration != null
            ? decoration!
            : BoxDecoration(
                color: backgroundColor ??
                    theme.boardContainerTheme.backgroundColor,
                borderRadius: borderRadius ?? BorderRadius.circular(15),
              ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            InkWell(
              onTap: onTap,
              child: Row(
                children: [
                  if (title != null) title!,
                  SizedBox(
                    width: (info != null) ? 8 : 0,
                  ),
                  if (info != null) info!,
                  const Spacer(),
                  if (trailing != null) trailing!,
                ],
              ),
            ),
            if (child != null)
              Padding(
                padding: const EdgeInsets.only(top: 8),
                child: child!,
              ),
          ],
        ),
      ),
    );
  }
}
