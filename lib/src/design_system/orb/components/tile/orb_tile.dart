import 'package:flutter/material.dart';

import '../../orb.dart';

class OrbTile extends StatelessWidget {
  final Widget? title;
  final VoidCallback? onTap;
  final Widget? leading;
  final Widget? trailing;
  final Color? backgroundColor;
  final EdgeInsetsGeometry? padding;

  const OrbTile({
    super.key,
    this.title,
    this.leading,
    this.trailing,
    this.onTap,
    this.backgroundColor,
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    final theme = OrbTheme.of(context);
    return InkWell(
      overlayColor: MaterialStateProperty.all(Colors.transparent),
      onTap: onTap,
      child: Container(
        padding: padding ?? const EdgeInsets.all(16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: backgroundColor ?? theme.tileTheme.backgroundColor,
        ),
        child: Row(
          children: [
            Expanded(
              child: Row(
                children: [
                  if (leading != null) leading!,
                  SizedBox(
                    width: leading != null ? 16 : 0,
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (title != null)
                          title!,
                      ],
                    ),
                  ),
                ],
              ),
            ),
            if (trailing != null) trailing!,
          ],
        ),
      ),
    );
  }
}
