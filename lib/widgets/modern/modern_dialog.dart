import 'package:danvery/utils/app_text_theme.dart';
import 'package:flutter/material.dart';
import 'package:orb/widgets/modern_button.dart';

class ModernDialog extends Dialog {
  final String title;
  final String content;
  final List<ModernButton> modernButtons;

  const ModernDialog(
      {super.key,
      required this.modernButtons,
      required this.title,
      required this.content});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Dialog(
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
                  style: appTextTheme.titleMedium,
                ),
                const SizedBox(height: 16),
                Text(content, style: appTextTheme.bodyLarge),
                const SizedBox(height: 24),
                Flex(
                  direction: Axis.horizontal,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    for (ModernButton modernButton in modernButtons)
                      Flexible(
                        flex: 1,
                        child: Padding(
                          padding: const EdgeInsets.only(right: 16),
                          child: modernButton,
                        ),
                      ),
                    Flexible(
                      flex: 1,
                      child: ModernButton(
                        mode: ModernButtonMode.fullWith,
                        style: ModernButtonStyle.filled,
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
  required List<ModernButton> modernButtons,
  required String title,
  required String content,
}) async {
  return await showDialog<T>(
    barrierDismissible: true,
    context: context,
    builder: (context) => ModernDialog(
      modernButtons: modernButtons,
      title: title,
      content: content,
    ),
  );
}
