import 'package:flutter/material.dart';

import '../../../utils/theme/app_text_theme.dart';
import '../../../utils/theme/palette.dart';

class CircleButton extends StatelessWidget{

  final String imagePath;
  final String text;
  final VoidCallback? onPressed;

  const CircleButton({super.key, required this.imagePath, required this.text, this.onPressed});

  @override
  Widget build(BuildContext context) {

    // TODO: implement build
    return Column(
      children: [
        IconButton(
            iconSize: 48,
            onPressed: onPressed,
            icon: Image.asset(
              imagePath,
            )
        ),
        Text(text,
          style: tinyStyle.copyWith(color: Palette.pureWhite),
          textAlign: TextAlign.center,
        )
      ],
    );
  }

}
