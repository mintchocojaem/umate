import 'package:flutter/material.dart';

import '../components.dart';

class OrbCardTile extends StatelessWidget implements OrbTile {
  @override
  final Widget? title;
  final String? titleText;
  final Color? titleTextColor;
  @override
  final Widget? content;
  final String? contentText;
  @override
  final VoidCallback? onTap;
  final Widget? subContent;
  final String? subContentText;
  final Color? subContentTextColor;
  final BoxConstraints? constraints;

  const OrbCardTile({
    super.key,
    this.title,
    this.titleText,
    this.titleTextColor,
    this.content,
    this.contentText,
    this.onTap,
    this.subContent,
    this.subContentText,
    this.subContentTextColor,
    this.constraints,
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
        constraints: constraints ?? const BoxConstraints(
          minHeight: 120,
          minWidth: 100,
        ),
        padding: const EdgeInsets.all(16),
        child: IntrinsicWidth(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  if (title != null) title!,
                  if (titleText != null)
                    Text(
                      titleText!,
                      style: theme.textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.w600,
                        color: titleTextColor,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  SizedBox(
                      height: (title != null) || (titleText != null) ? 4 : 0),
                  if (content != null) content!,
                  if (contentText != null)
                    Text(
                      contentText!,
                      style: theme.textTheme.bodyMedium,
                      textAlign: TextAlign.center,
                    ),
                ],
              ),
              if (subContent != null) subContent!,
              if (subContentText != null)
                Text(
                  subContentText!,
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: subContentTextColor ?? theme.colorScheme.secondary,
                    fontWeight: FontWeight.w600,
                  ),
                  textAlign: TextAlign.center,
                ),
            ],
          ),
        ),
      ),
    );
  }
}