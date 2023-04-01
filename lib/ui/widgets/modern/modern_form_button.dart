import 'package:danvery/core/theme/palette.dart';
import 'package:flutter/cupertino.dart';
import 'package:tap_debouncer/tap_debouncer.dart';

import '../../../core/theme/app_text_theme.dart';

class ModernFormButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final bool isEnabled;

  const ModernFormButton(
      {super.key,
      required this.text,
      required this.onPressed,
      this.isEnabled = true});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 48,
      child: TapDebouncer(
        cooldown: const Duration(seconds: 1),
        onTap: () async => isEnabled ? onPressed() : null,
        builder: (BuildContext context, Future<void> Function()? onTap) {
          return CupertinoButton(
            disabledColor: Palette.lightGrey,
            borderRadius: BorderRadius.circular(5),
            color: Palette.blue,
            onPressed: onTap,
            child: Text(text,
                style: regularStyle.copyWith(
                    color: isEnabled ? Palette.white : Palette.grey)),
          );
        },
      ),
    );
  }
}
