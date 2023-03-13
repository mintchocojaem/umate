import 'package:danvery/app/ui/theme/app_text_theme.dart';
import 'package:danvery/app/ui/theme/palette.dart';
import 'package:flutter/cupertino.dart';

class LoginFormButton extends StatelessWidget {

  final String text;
  final VoidCallback onPressed;
  final bool isEnabled;

  const LoginFormButton({super.key, required this.text, required this.onPressed , this.isEnabled = true});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 48,
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
