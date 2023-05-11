import 'package:flutter/material.dart';
import 'package:orb/orbs/blue_flame_orb/blue_flame_orb.dart';

enum OrbButtonMode{
  compact,
  full,
  fullWith,
}

enum OrbButtonStyle {
  filled,
  tonal,
}

class OrbButton extends StatelessWidget {
  final OrbButtonMode mode;
  final OrbButtonStyle style;
  final void Function()? onPressed;
  final String text;
  final Color? enabledBackgroundColor;
  final Color? disabledBackgroundColor;
  final TextStyle? enabledTextStyle;
  final TextStyle? disabledTextStyle;
  final bool enabled;

  const OrbButton({
    super.key,
    this.mode = OrbButtonMode.full,
    this.style = OrbButtonStyle.filled,
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

    final orb = BlueFlameOrb(context);
    orb.init();

    final width = mode == OrbButtonMode.compact ? null : double.infinity;
    final height = mode == OrbButtonMode.full ? 58.0 : null;

    return Theme(
      data: orb.themeData,
      child: SizedBox(
        width: width,
        height: height,
        child: FilledButton(
          onPressed: enabled ? onPressed : null,
          child: Text(text),
        ),
      ),
    );
  }
}
