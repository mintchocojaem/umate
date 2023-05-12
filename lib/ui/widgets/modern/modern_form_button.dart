import 'package:danvery/core/theme/palette.dart';
import 'package:flutter/material.dart';

import '../../../core/theme/app_text_theme.dart';

class ModernFormButton extends StatefulWidget {
  final String text;
  final VoidCallback onPressed;
  final bool isEnabled;
  final int coolDownTime;
  final double width;
  final double height;
  final TextStyle? textStyle;
  final Color? enabledBackgroundColor;
  final Color? disabledBackgroundColor;
  final Color? enabledTextColor;
  final Color? disabledTextColor;
  final double elevation;

  const ModernFormButton({
    Key? key,
    required this.text,
    required this.onPressed,
    this.isEnabled = true,
    this.coolDownTime = 1,
    this.width = double.infinity,
    this.height = 48,
    this.textStyle,
    this.enabledBackgroundColor,
    this.disabledBackgroundColor,
    this.enabledTextColor,
    this.disabledTextColor,
    this.elevation = 0,
  }) : super(key: key);

  @override
  createState() => _ModernFormButton();
}

class _ModernFormButton extends State<ModernFormButton> {
  bool coolDown = false;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.width,
      height: widget.height,
      child: MaterialButton(
        highlightColor: Colors.transparent,
        splashColor: Colors.transparent,
        elevation: widget.elevation,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        padding: EdgeInsets.zero,
        disabledColor: widget.disabledBackgroundColor ?? Palette.lightGrey,
        color: widget.enabledBackgroundColor ?? Palette.blue,
        onPressed: widget.isEnabled && !coolDown
            ? () async {
                widget.onPressed();

                if (mounted) {
                  setState(() {
                    coolDown = true;
                  });
                }

                await Future.delayed(Duration(seconds: widget.coolDownTime));

                if (mounted) {
                  setState(() {
                    coolDown = false;
                  });
                }
              }
            : null,
        child: Text(
          widget.text,
          style: widget.textStyle ??
              regularStyle.copyWith(
                  color: widget.isEnabled && !coolDown
                      ? widget.enabledTextColor ?? Palette.white
                      : widget.disabledTextColor ?? Palette.grey,
                  fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
