import 'package:danvery/modules/orb/components/button/orb_button.dart';
import 'package:flutter/material.dart';

class OrbDialog extends StatelessWidget {
  final String title;
  final Widget content;
  final String? rightButtonText;
  final String? leftButtonText;
  final Function() onRightButtonPressed;
  final Function() onLeftButtonPressed;

  const OrbDialog({
    super.key,
    required this.title,
    required this.content,
    this.rightButtonText,
    this.leftButtonText,
    required this.onRightButtonPressed,
    required this.onLeftButtonPressed,
  });

  Future<void> show(BuildContext context) {
    return showDialog<void>(
      builder: (BuildContext context) => this,
      context: context,
    );
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    bool disableButtonAction = false;

    return AlertDialog(
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
                    onPressed: () {
                      if(disableButtonAction) return;
                      disableButtonAction = true;
                      Future(() async{
                        await onLeftButtonPressed.call();
                      }).whenComplete((){
                        disableButtonAction = false;
                        Navigator.pop(context);
                      });
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
                    onPressed: () {
                      if(disableButtonAction) return;
                      disableButtonAction = true;
                      Future(() async{
                        await onRightButtonPressed.call();
                      }).whenComplete((){
                        disableButtonAction = false;
                        Navigator.pop(context);
                      });
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
    );
  }
}
