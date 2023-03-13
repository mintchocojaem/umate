import 'package:flutter/material.dart';
import '../../theme/app_text_theme.dart';
import '../../theme/palette.dart';

class StepGuide extends StatelessWidget {

  final int stepLength;
  final int currentStep;

  const StepGuide({super.key, required this.stepLength, required this.currentStep});

  @override
  Widget build(BuildContext context) {

    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        for (int i = 0; i < stepLength; i++)
          Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: Container(
              height: currentStep -1 == i ? 24 : 12,
              width: currentStep -1 == i ? 24 : 12,
              decoration: BoxDecoration(
                color: currentStep -1 == i ? Palette.blue : Palette.grey,
                shape: BoxShape.circle,
              ),
              child: currentStep -1 == i ? Center(
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
