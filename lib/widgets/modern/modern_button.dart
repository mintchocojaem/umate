import 'package:flutter/material.dart';

enum ModernButtonMode{
  compact,
  full,
  fullWith,
}

enum ModernButtonStyle {
  filled,
  tonal,
}

class ModernButton extends StatelessWidget {
  final ModernButtonMode mode;
  final ModernButtonStyle style;
  final void Function()? onPressed;
  final String text;
  final Color? enabledBackgroundColor;
  final Color? disabledBackgroundColor;
  final TextStyle? enabledTextStyle;
  final TextStyle? disabledTextStyle;
  final bool enabled;

  const ModernButton({
    super.key,
    this.mode = ModernButtonMode.full,
    this.style = ModernButtonStyle.filled,
    required this.onPressed,
    required this.text,
    this.enabledBackgroundColor,
    this.disabledBackgroundColor,
    this.enabledTextStyle,
    this.disabledTextStyle,
    this.enabled = true,
  });

  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    final width = mode == ModernButtonMode.compact ? null : double.infinity;
    final height = mode == ModernButtonMode.full ? 58.0 : null;

    return SizedBox(
      width: width,
      height: height,
      child: FilledButton(
        onPressed: enabled ? onPressed : null,
        child: Text(text),
      ),
    );
  }
}
