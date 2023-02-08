import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../palette/palette.dart';


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
            iconSize: 36,
            onPressed: onPressed,
            icon: Image.asset(
              imagePath,
            )
        ),
        Text(text,
          style: TextStyle(color: Palette.white, fontSize: 12,),
          textAlign: TextAlign.center,
        )
      ],
    );
  }

}
