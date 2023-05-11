import 'package:danvery/module/orb/orb.dart';
import 'package:flutter/material.dart';

enum OrbButtonMode {
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
  final bool enabled;

  const OrbButton({
    super.key,
    this.mode = OrbButtonMode.full,
    this.style = OrbButtonStyle.filled,
    required this.onPressed,
    required this.text,
    this.enabled = true,
  });

  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    final blueFlameOrb = Orb.ofType(OrbType.blueFlame, brightness: Theme.of(context).brightness);

    final width = mode == OrbButtonMode.compact ? null : double.infinity;
    final height = mode == OrbButtonMode.full ? 58.0 : null;

    return SizedBox(
      width: width,
      height: height,
      child: FilledButton(
        style: style == OrbButtonStyle.tonal ? ButtonStyle(
          backgroundColor: MaterialStateProperty.all<Color>(
              blueFlameOrb.getOrbMode().colorScheme.surfaceVariant
          ),
          foregroundColor: MaterialStateProperty.all<Color>(
            blueFlameOrb.getOrbMode().colorScheme.onSurfaceVariant,
          ),
        ) : null,
        onPressed: enabled ? onPressed : null,
        child: Text(text),
      ),
    );
  }
}
