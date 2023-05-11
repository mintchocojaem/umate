import 'package:danvery/module/orb/orb.dart';
import 'package:flutter/material.dart';

class OrbDialog extends Dialog {
  final String title;
  final String content;
  final List<OrbButton> buttons;

  const OrbDialog(
      {super.key,
      required this.buttons,
      required this.title,
      required this.content});

  @override
  Widget build(BuildContext context) {

    ThemeData themeData = Theme.of(context);

    // TODO: implement build
    return Dialog(
      backgroundColor: themeData.colorScheme.surface,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(15.0)),
        ),
        insetPadding: const EdgeInsets.symmetric(horizontal: 32),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SizedBox(
            width: double.infinity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                const SizedBox(height: 16),
                Text(
                  title,
                  style: themeData.textTheme.titleMedium,
                ),
                const SizedBox(height: 16),
                Text(
                  content,
                  style: themeData.textTheme.bodyLarge,
                ),
                const SizedBox(height: 24),
                Flex(
                  direction: Axis.horizontal,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    for (OrbButton modernButton in buttons)
                      Flexible(
                        flex: 1,
                        child: Padding(
                          padding: const EdgeInsets.only(right: 16),
                          child: modernButton,
                        ),
                      ),
                    Flexible(
                      flex: 1,
                      child: OrbButton(
                        mode: OrbButtonMode.fullWith,
                        style: OrbButtonStyle.filled,
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        text: "확인",
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ));
  }
}

Future<T?> showModernDialog<T>({
  required BuildContext context,
  required List<OrbButton> modernButtons,
  required String title,
  required String content,
}) async {
  return await showDialog<T>(
    barrierDismissible: true,
    context: context,
    builder: (context) => OrbDialog(
      buttons: modernButtons,
      title: title,
      content: content,
    ),
  );
}
