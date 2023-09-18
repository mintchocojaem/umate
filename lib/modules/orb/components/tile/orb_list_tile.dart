import 'package:flutter/material.dart';

import '../components.dart';

enum TileTextStyle {
  medium,
  large,
}

class OrbListTile extends StatelessWidget implements OrbTile {
  @override
  final String title;
  final bool boldTitle;
  final TileTextStyle? tileTextStyle;
  @override
  final String? content;
  final CrossAxisAlignment? contentAlign;
  @override
  final VoidCallback? onTap;
  final Widget? leading;
  final Widget? trailing;

  const OrbListTile({
    super.key,
    required this.title,
    this.boldTitle = false,
    this.tileTextStyle = TileTextStyle.medium,
    this.content,
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
                if(leading != null) leading!,
                SizedBox(
                  width: leading != null ? 16 : 0,
                ),
                Text(
                  title,
                  style: (tileTextStyle == TileTextStyle.medium
                          ? theme.textTheme.bodyMedium
                          : theme.textTheme.bodyLarge)
                      ?.copyWith(
                          fontWeight:
                              boldTitle ? FontWeight.w600 : FontWeight.w500,
                          overflow: TextOverflow.ellipsis),
                ),
                const SizedBox(
                  width: 32,
                ),
                if (content != null)
                  Expanded(
                    child: Column(
                      crossAxisAlignment:
                          contentAlign ?? CrossAxisAlignment.start,
                      children: [
                        Text(
                          content!,
                          style: (tileTextStyle == TileTextStyle.medium
                                  ? theme.textTheme.bodyMedium
                                  : theme.textTheme.bodyLarge)
                              ?.copyWith(
                            fontWeight: FontWeight.w500,
                            overflow: TextOverflow.ellipsis,
                          ),
                          maxLines: 2,
                        ),
                      ],
                    ),
                  ),
              ],
            ),
          ),
          if(trailing != null) trailing!
        ],
      ),
    );
  }
}
