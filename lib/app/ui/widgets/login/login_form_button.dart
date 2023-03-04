import 'package:danvery/app/ui/theme/app_text_theme.dart';
import 'package:flutter/cupertino.dart';

import '../../theme/app_colors.dart';

class LoginFormButton extends StatelessWidget {

  final String text;
  final VoidCallback onPressed;

  const LoginFormButton({super.key, required this.text, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 48,
      child: CupertinoButton(
        color: blue,
        onPressed: onPressed,
        child: Text(
          text,
          style: regularStyle
        ),
      ),
    );
  }
}
