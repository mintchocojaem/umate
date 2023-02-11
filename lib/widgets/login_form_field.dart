import 'package:danvery/settings/font_size.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../settings/palette.dart';

class LoginFormField extends StatelessWidget {

  final String? title;
  final String? hint;
  final bool checkButton;

  const LoginFormField({
    super.key,
    this.hint,
    this.title,
    this.checkButton = false,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        title == null
            ? const SizedBox()
            : Text(title!, style: TextStyle(fontSize: FontSize.titleFont, color: Palette.lightGrey, fontWeight: FontWeight.bold),),
        SizedBox(height: 8,),
        Row(
          children: [
            Expanded(
              child: SizedBox(
                height: 48,
                child: TextField(
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Palette.whiteGrey,
                    border: OutlineInputBorder(),
                    hintText: hint,
                    hintStyle: TextStyle(color: Palette.lightGrey),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5),
                      borderSide: BorderSide(
                        color: Palette.whiteGrey,
                        width: 1.0,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(width: 8,),
            checkButton ?
            SizedBox(
              height: 48,
              child: OutlinedButton(
                onPressed: null,
                style: ButtonStyle(
                  side: MaterialStateProperty.all(BorderSide(color: Palette.lightGrey)),
                  shape: MaterialStateProperty.all(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5),
                      )
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(left: 16, right: 16),
                  child: Text("중복확인", style: TextStyle(color: Palette.lightGrey),),
                ),
              )
            ) : const SizedBox()
          ],
        ),
      ],
    );
  }
}
