import 'package:danvery/settings/font_size.dart';
import 'package:danvery/settings/palette.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

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
        color: Palette.blue,
        onPressed: onPressed,
        child: Text(
          text,
          style: const TextStyle(
            fontSize: FontSize.regularFont,
          ),
        ),
      ),
    );
  }
}
