import 'package:danvery/settings/font_size.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../settings/palette.dart';

class MainButton extends StatelessWidget{

  final String imagePath;
  final String text;
  final VoidCallback? onPressed;

  const MainButton({super.key, required this.imagePath, required this.text, this.onPressed});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Column(
      children: [
        IconButton(
            iconSize: 42,
            onPressed: onPressed,
            icon: Image.asset(
              imagePath,
            )
        ),
        Text(text,
          style: TextStyle(color: Palette.white, fontSize: FontSize.lightFont,),
          textAlign: TextAlign.center,
        )
      ],
    );
  }

}
