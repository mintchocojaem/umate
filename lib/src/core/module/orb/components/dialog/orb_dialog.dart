import 'package:flutter/material.dart';

import '../components.dart';

class OrbDialog {
  late final String title;
  late final Widget content;
  late final String? rightButtonText;
  late final String? leftButtonText;
  late final Future<bool> Function() onRightButtonPressed;
  late final Future<bool> Function() onLeftButtonPressed;
  late final GlobalKey<NavigatorState> navigatorKey;

  static final OrbDialog _instance = OrbDialog._internal();

  OrbDialog._internal();

  factory OrbDialog() {
    return _instance;
  }

  OrbDialog.init({
    required this.navigatorKey,
  }) {
    final dialog = OrbDialog();
    dialog.navigatorKey = navigatorKey;
  }

  factory OrbDialog.show({
    required String title,
    required Widget content,
    required String? rightButtonText,
    required String? leftButtonText,
    required Future<bool> Function() onRightButtonPressed,
    required Future<bool> Function() onLeftButtonPressed,
  }) {
    final dialog = OrbDialog();
    dialog._show(
      title: title,
      content: content,
      rightButtonText: rightButtonText,
      leftButtonText: leftButtonText,
      onRightButtonPressed: onRightButtonPressed,
      onLeftButtonPressed: onLeftButtonPressed,
    );
    return dialog;
  }

  Future<dynamic> _show({
    required String title,
    required Widget content,
    required String? rightButtonText,
    required String? leftButtonText,
    required Future<bool> Function() onRightButtonPressed,
    required Future<bool> Function() onLeftButtonPressed,
  }) {
    final BuildContext? context = navigatorKey.currentState?.overlay?.context;

    if (context == null) {
      return Future.value(false);
    }

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
                      onPressed: () async {
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
                  width: rightButtonText != null && leftButtonText != null
                      ? 16
                      : 0),
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
