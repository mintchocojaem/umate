import 'package:danvery/modules/orb/components/container/orb_container.dart';
import 'package:flutter/material.dart';

class OrbBoardContainer extends StatelessWidget implements OrbContainer {
  @override
  final Widget? title;
  final String? titleText;
  @override
  final Widget? info;
  final String? infoText;
  final Color? infoColor;
  @override
  final Widget? child;
  @override
  final Decoration? decoration;
  @override
  final Widget? trailing;

  const OrbBoardContainer({
    super.key,
    this.title,
    this.titleText,
    this.info,
    this.infoText,
    this.infoColor,
    this.decoration,
    this.trailing,
    this.child,
  });

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    final ThemeData themeData = Theme.of(context);
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: decoration != null
          ? decoration!
          : BoxDecoration(
              color: themeData.colorScheme.surface,
              borderRadius: BorderRadius.circular(15),
            ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              if (title != null) title!,
              if (titleText != null)
                Text(
                  titleText!,
                  style: themeData.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
              SizedBox(
                width: (info != null) || (infoText != null) ? 8 : 0,
              ),
              if (info != null) info!,
              if (infoText != null)
                Text(
                  infoText!,
                  style: themeData.textTheme.bodySmall?.copyWith(
                    fontWeight: FontWeight.w600,
                    color: infoColor ?? themeData.colorScheme.primary,
                  ),
                ),
              const Spacer(),
              if (trailing != null) trailing!,
            ],
          ),
          const SizedBox(
            height: 16,
          ),
          if (child != null) child!,
        ],
      ),
    );
  }
}
