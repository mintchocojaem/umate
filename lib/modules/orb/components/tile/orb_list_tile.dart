import 'package:flutter/material.dart';

import '../components.dart';

enum TileTextStyle {
  medium,
  large,
}

class OrbListTile extends StatelessWidget implements OrbTile {
  @override
  final Widget? title;
  final String? titleText;
  final bool boldTitleText;
  final TileTextStyle? tileTextStyle;
  @override
  final Widget? content;
  final String? contentText;
  final CrossAxisAlignment? contentAlign;
  @override
  final VoidCallback? onTap;
  final Widget? leading;
  final Widget? trailing;

  const OrbListTile({
    super.key,
    this.title,
    this.titleText,
    this.boldTitleText = false,
    this.tileTextStyle = TileTextStyle.medium,
    this.content,
    this.contentText,
    this.contentAlign = CrossAxisAlignment.start,
    this.leading,
    this.trailing,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return InkWell(
      onTap: onTap,
      child: Row(
        children: [
          Expanded(
            child: Row(
              children: [
                if (leading != null) leading!,
                SizedBox(
                  width: leading != null ? 16 : 0,
                ),
                if (title != null) title!,
                if (titleText != null)
                  Text(
                    titleText!,
                    style: (tileTextStyle == TileTextStyle.medium
                            ? theme.textTheme.bodyMedium
                            : theme.textTheme.bodyLarge)
                        ?.copyWith(
                      fontWeight:
                          boldTitleText ? FontWeight.w600 : FontWeight.w500,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                const SizedBox(
                  width: 16,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment:
                        contentAlign ?? CrossAxisAlignment.start,
                    children: [
                      if (content != null) content!,
                      if (contentText != null)
                        Text(
                          contentText!,
                          style: (tileTextStyle == TileTextStyle.medium
                                  ? theme.textTheme.bodyMedium
                                  : theme.textTheme.bodyLarge)
                              ?.copyWith(
                            fontWeight: FontWeight.w500,
                            overflow: TextOverflow.ellipsis,
                          ),
                          maxLines: 1,
                        ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          if (trailing != null) trailing!
        ],
      ),
    );
  }
}
