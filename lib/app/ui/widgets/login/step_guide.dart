import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../theme/app_text_theme.dart';
import '../../theme/palette.dart';

class StepGuide extends StatelessWidget {

  final List<String> step;
  final int currentStep;

  const StepGuide({super.key, required this.step, required this.currentStep});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        for (int i = 0; i < step.length; i++)
          Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: Container(
              height: currentStep == i ? 24 : 12,
              width: currentStep == i ? 24 : 12,
              decoration: BoxDecoration(
                color: i == 0 ? Palette.blue : Palette.grey,
                shape: BoxShape.circle,
              ),
              child: currentStep == i ? Center(
                child: Text(
                  "0${i + 1}",
                  style: tinyStyle.copyWith(
                    color: Palette.pureWhite,
                  ),
                ),
              ) : const SizedBox()
            ),
          ),
      ],
    );
  }
}
