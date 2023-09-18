import 'package:flutter/material.dart';

import '../components.dart';

class OrbCardTile extends StatelessWidget implements OrbTile {
  @override
  final String title;
  final Color? titleColor;
  @override
  final String? content;
  @override
  final VoidCallback? onTap;
  final String? subContent;
  final Color? subContentColor;

  const OrbCardTile({
    super.key,
    required this.title,
    this.titleColor,
    this.content,
    this.onTap,
    this.subContent,
    this.subContentColor,
  });

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return InkWell(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: theme.colorScheme.onBackground,
          borderRadius: BorderRadius.circular(15),
        ),
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Text(
              title,
              style: theme.textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.w600,
                color: titleColor,
              ),
            ),
            SizedBox(
              height: content != null ? 4 : 0,
            ),
            if (content != null)
              Text(
                content!,
                style: theme.textTheme.bodyMedium,
              ),
            SizedBox(
              height: subContent != null ? 4 : 0,
            ),
            if (subContent != null)
              Text(
                subContent!,
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: subContentColor ?? theme.colorScheme.secondary,
                  fontWeight: FontWeight.w600,
                ),
              ),
          ],
        ),
      ),
    );
  }
}
