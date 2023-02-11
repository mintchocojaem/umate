import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../settings/palette.dart';

class LoginFormField extends StatelessWidget {

  final String? title;
  final String? hint;

  const LoginFormField({super.key, this.hint, this.title});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        title == null
            ? const SizedBox()
            : Text(title!,),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 8, vertical: 16),
          child: TextField(
            decoration: InputDecoration(
              filled: true,
              fillColor: Palette.sky,
              border: OutlineInputBorder(),
              hintText: hint,
              hintStyle: TextStyle(color: Palette.lightBlue),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(
                  color: Palette.blue,
                  width: 1.0,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
