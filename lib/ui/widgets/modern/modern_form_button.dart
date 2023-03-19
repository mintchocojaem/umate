import 'package:flutter/cupertino.dart';

import '../../../utils/theme/app_text_theme.dart';
import '../../../utils/theme/palette.dart';

class ModernFormButton extends StatelessWidget {

  final String text;
  final VoidCallback onPressed;
  final bool isEnabled;

  const ModernFormButton({super.key, required this.text, required this.onPressed , this.isEnabled = true});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 54,
      child: CupertinoButton(
        disabledColor: Palette.grey,
        borderRadius: BorderRadius.circular(5),
        color: Palette.blue,
        onPressed: isEnabled ? onPressed : null,
        child: Text(
          text,
          style: regularStyle
        ),
      ),
    );
  }
}
