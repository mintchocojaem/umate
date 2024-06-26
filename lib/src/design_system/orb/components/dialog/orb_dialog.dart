import 'package:flutter/material.dart';

import '../../orb.dart';

class OrbDialog extends StatelessWidget {
  final String title;
  final Widget content;
  final String? rightButtonText;
  final String? leftButtonText;
  final Color?  rightButtonColor;
  final Color?  leftButtonColor;
  final Future<bool> Function() onRightButtonPressed;
  final Future<bool> Function() onLeftButtonPressed;

  const OrbDialog({
    super.key,
    required this.title,
    required this.content,
    this.rightButtonText,
    this.leftButtonText,
    this.rightButtonColor,
    this.leftButtonColor,
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

    bool disableButtonAction = false;

    final theme = OrbTheme.of(context);
    final currentPalette = theme.getCurrentPalette(context);
    return AlertDialog(
      surfaceTintColor: theme.dialogTheme.backgroundColor,
      backgroundColor: theme.dialogTheme.backgroundColor,
      insetPadding: const EdgeInsets.all(32),
      title: Text(
        title,
        style: theme.textTheme.titleMedium,
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
                  child: OrbFilledButton(
                    backgroundColor: leftButtonColor ?? currentPalette.surface,
                    onPressed: () async {
                      if (disableButtonAction) return;
                      disableButtonAction = true;
                      final result = await onLeftButtonPressed.call();
                      disableButtonAction = false;
                      if (result && context.mounted) {
                        Navigator.pop(context);
                      }
                    },
                    text: leftButtonText!,
                  ),
                ),
              ),
            SizedBox(
              width: rightButtonText != null && leftButtonText != null ? 16 : 0,
            ),
            if (rightButtonText != null)
              Flexible(
                flex: 1,
                child: SizedBox(
                  width: double.infinity,
                  child: OrbFilledButton(
                    backgroundColor: rightButtonColor,
                    onPressed: () async {
                      if (disableButtonAction) return;
                      disableButtonAction = true;
                      final result = await onRightButtonPressed.call();
                      disableButtonAction = false;
                      if (result && context.mounted) {
                        Navigator.pop(context);
                      }
                    },
                    text: rightButtonText!,
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
