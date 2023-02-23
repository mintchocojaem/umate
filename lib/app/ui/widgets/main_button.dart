import 'package:danvery/app/ui/theme/app_text_theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../theme/app_colors.dart';

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
          style: lightStyle.copyWith(color: white),
          textAlign: TextAlign.center,
        )
      ],
    );
  }

}
