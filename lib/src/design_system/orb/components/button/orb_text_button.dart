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
     final theme = OrbTheme.of(context);
    return TextButton(
      style: ButtonStyle(
        foregroundColor: MaterialStateProperty.all(
          theme.textButtonTheme.textColor,
        ),
        overlayColor: MaterialStateProperty.all(Colors.transparent),
        padding: MaterialStateProperty.all(
          const EdgeInsets.all(0),
        ),
        minimumSize: MaterialStateProperty.all(
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
