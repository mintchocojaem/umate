import 'package:flutter/material.dart';

import '../../../../../../modules/modules.dart';

class AgreePolicySubmitButton extends StatelessWidget {
  final ValueNotifier<bool> valueNotifier;
  final String Function() submitButtonText;
  final Function() onPressed;
  final OrbButtonRadius? buttonRadius;

  const AgreePolicySubmitButton({
    super.key,
    required this.valueNotifier,
    required this.submitButtonText,
    required this.onPressed,
    this.buttonRadius,
  });

  changeButtonRadius({
    OrbButtonRadius? buttonRadius,
  }) {
    return AgreePolicySubmitButton(
      valueNotifier: valueNotifier,
      submitButtonText: submitButtonText,
      onPressed: onPressed,
      buttonRadius: buttonRadius,
    );
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: valueNotifier,
      builder: (context, value, child) {
        return OrbButton(
          buttonText: submitButtonText(),
          onPressed: () async {
            await onPressed();
          },
        ).copyWith(
          buttonRadius: buttonRadius,
        );
      },
    );
  }
}
