import 'package:danvery/modules/orb/components/button/orb_button.dart';
import 'package:flutter/material.dart';

import '../../../../main.dart';

class OrbDialog{
  final String title;
  final Widget content;
  final String? rightButtonText;
  final String? leftButtonText;
  final Future<bool> Function() onRightButtonPressed;
  final Future<bool> Function() onLeftButtonPressed;

  OrbDialog({
    required this.title,
    required this.content,
    required this.onRightButtonPressed,
    required this.onLeftButtonPressed,
    this.rightButtonText,
    this.leftButtonText,
  });

  Future<dynamic> show(){
    final BuildContext context = navigatorKey.currentState!.overlay!.context;
    final ThemeData theme = Theme.of(context);

    bool disableButtonAction = false;

    return showDialog(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        surfaceTintColor: theme.colorScheme.background,
        backgroundColor: theme.colorScheme.background,
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
                      onPressed: () async{
                        if (disableButtonAction) return;
                        disableButtonAction = true;
                        final result = await onLeftButtonPressed.call();
                        disableButtonAction = false;
                        if (result && context.mounted) {
                          Navigator.pop(context);
                        }
                      },
                      enabledBackgroundColor: theme.colorScheme.surfaceVariant,
                      enabledForegroundColor: theme.colorScheme.onSurface,
                      buttonText: leftButtonText,
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
                      enabledBackgroundColor: theme.colorScheme.secondary,
                      enabledForegroundColor: theme.colorScheme.onSecondary,
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
      ),
    );
  }

}
