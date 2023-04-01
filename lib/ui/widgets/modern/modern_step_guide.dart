import 'package:danvery/core/theme/palette.dart';
import 'package:flutter/material.dart';

import '../../../core/theme/app_text_theme.dart';

class ModernStepGuide extends StatelessWidget {

  final int stepLength;
  final int currentStep;

  const ModernStepGuide({super.key, required this.stepLength, required this.currentStep});

  @override
  Widget build(BuildContext context) {

    return Row(
      children: [
        for (int i = 0; i < stepLength; i++)
          Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: Container(
              alignment: Alignment.center,
              height: currentStep -1 == i ? 24 : 12,
              width: currentStep -1 == i ? 24 : 12,
              decoration: BoxDecoration(
                color: currentStep -1 == i ? Palette.blue : Palette.grey,
                shape: BoxShape.circle,
              ),
              child: currentStep -1 == i ? Text(
                "0${i + 1}",
                style: tinyStyle.copyWith(
                  color: Palette.pureWhite,
                  fontWeight: FontWeight.w500,
                  height: 1.0,
                ),
              ) : const SizedBox(),
            ),
          ),
      ],
    );
  }
}
