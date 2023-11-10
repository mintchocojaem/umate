import 'package:danvery/modules/orb/components/button/orb_button.dart';
import 'package:flutter/material.dart';

class OrbDialog extends StatelessWidget {
  final String title;
  final String message;
  final String? rightButtonText;
  final String? leftButtonText;
  final VoidCallback? onRightButtonPressed;
  final VoidCallback? onLeftButtonPressed;

  const OrbDialog({
    super.key,
    required this.title,
    required this.message,
    this.rightButtonText,
    this.leftButtonText,
    this.onRightButtonPressed,
    this.onLeftButtonPressed,
  });

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return AlertDialog(
        surfaceTintColor: theme.colorScheme.onSurface,
        title: Text(
          title,
          style: theme.textTheme.titleSmall?.copyWith(
            color: theme.colorScheme.onSurface,
            fontWeight: FontWeight.w600,
          ),
        ),
        content: Text(
          message,
          style: theme.textTheme.bodyMedium,
        ),
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
                        onLeftButtonPressed?.call();
                        Navigator.pop(context);
                      },
                      buttonTheme: OrbButtonTheme.onSurface,
                      buttonText: leftButtonText,
                    ),
                  ),
                ),
              SizedBox(
                  width: rightButtonText != null && leftButtonText != null
                      ? 16
                      : 0),
              if (rightButtonText != null)
                Flexible(
                  flex: 1,
                  child: SizedBox(
                    width: double.infinity,
                    child: OrbButton(
                      onPressed: () async{
                        onRightButtonPressed?.call();
                        Navigator.pop(context);
                      },
                      buttonText: rightButtonText,
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
        ));
  }
}
