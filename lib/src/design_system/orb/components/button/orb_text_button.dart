import 'package:flutter/material.dart';

import '../../orb.dart';

class OrbTextButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String text;
  final OrbTextType buttonTextType;
  final Color? textColor;

  const OrbTextButton({
    super.key,
    required this.onPressed,
    required this.text,
    this.textColor,
    this.buttonTextType = OrbTextType.bodyMedium,
  });

  @override
  Widget build(BuildContext context) {
    final themeData = OrbThemeData.of(context);
    final palette = themeData.palette;
    return TextButton(
      style: ButtonStyle(
        foregroundColor: WidgetStateProperty.all(
          palette.primary,
        ),
        overlayColor: WidgetStateProperty.all(Colors.transparent),
        padding: WidgetStateProperty.all(
          const EdgeInsets.all(0),
        ),
        minimumSize: WidgetStateProperty.all(
          const Size(0, 0),
        ),
      ),
      onPressed: onPressed,
      child: OrbText(
        text,
        type: buttonTextType,
        color: textColor,
        height: 1.0,
      ),
    );
  }
}
