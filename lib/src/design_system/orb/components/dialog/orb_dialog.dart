import 'package:flutter/material.dart';

import '../button/orb_button.dart';


class OrbDialog extends StatelessWidget {

  final String title;
  final Widget content;
  final String? rightButtonText;
  final String? leftButtonText;
  final Future<bool> Function() onRightButtonPressed;
  final Future<bool> Function() onLeftButtonPressed;

  const OrbDialog({
    super.key,
    required this.title,
    required this.content,
    this.rightButtonText,
    this.leftButtonText,
    required this.onRightButtonPressed,
    required this.onLeftButtonPressed,
  });

  Future<void> show(BuildContext? context) async {
    await showDialog(
      context: context!,
      builder: (context) {
        return this;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    final ThemeData theme = Theme.of(context);

    bool disableButtonAction = false;

    return AlertDialog(
      surfaceTintColor: theme.colorScheme.surface,
      backgroundColor: theme.colorScheme.surface,
      insetPadding: const EdgeInsets.all(32),
      title: Text(
        title,
        style: theme.textTheme.titleSmall?.copyWith(
          color: theme.colorScheme.onSurface,
          fontWeight: FontWeight.w600,
        ),
      ),
      content: content,
      actions: [
        Flex(
          direction: Axis.horizontal,
          children: [
            if (leftButtonText != null)
              Flexible(
                flex: 1,
                child: SizedBox(
                  width: double.infinity,
                  child: OrbButton(
                    onPressed: () async {
                      if (disableButtonAction) return;
                      disableButtonAction = true;
                      final result = await onLeftButtonPressed.call();
                      disableButtonAction = false;
                      if (result && context.mounted) {
                        Navigator.pop(context);
                      }
                    },
                    buttonText: leftButtonText,
                    buttonStyle: OrbButtonStyle.tertiary,
                  ),
                ),
              ),
            SizedBox(
                width:
                    rightButtonText != null && leftButtonText != null ? 16 : 0),
            if (rightButtonText != null)
              Flexible(
                flex: 1,
                child: SizedBox(
                  width: double.infinity,
                  child: OrbButton(
                    onPressed: () async {
                      if (disableButtonAction) return;
                      disableButtonAction = true;
                      final result = await onRightButtonPressed.call();
                      disableButtonAction = false;
                      if (result && context.mounted) {
                        Navigator.pop(context);
                      }
                    },
                    buttonText: rightButtonText,
                    buttonStyle: OrbButtonStyle.primary,
                  ),
                ),
              ),
          ],
        ),
      ],
      actionsPadding: const EdgeInsets.only(right: 16, left: 16, bottom: 16),
      actionsAlignment: MainAxisAlignment.spaceEvenly,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
    );
  }
}
