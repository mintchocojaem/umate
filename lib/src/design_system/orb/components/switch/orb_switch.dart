import 'package:flutter/cupertino.dart';

import '../../orb.dart';

class OrbSwitch extends StatelessWidget {

  final bool value;

  final void Function(bool) onChanged;

  const OrbSwitch({
    super.key,
    this.value = false,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    final theme = OrbTheme.of(context);
    final currentPalette = theme.getCurrentPalette(context);
    return CupertinoSwitch(
      value: value,
      activeColor: currentPalette.primary,
      onChanged: onChanged,
    );
  }
}
