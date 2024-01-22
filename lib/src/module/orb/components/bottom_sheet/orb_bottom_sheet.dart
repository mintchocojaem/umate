import 'package:danvery/src/module/orb/theme/orb_palette.dart';
import 'package:danvery/src/module/orb/theme/orb_theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SheetItem {
  final String title;
  final Color? color;
  final Future Function()? onPressed;

  SheetItem({
    required this.title,
    required this.onPressed,
    this.color,
  });
}

class OrbBottomSheet extends StatelessWidget {
  const OrbBottomSheet({
    super.key,
    required this.items,
  });

  final List<SheetItem> items;

  Future<void> show(context) async {
    await showCupertinoModalPopup(
      barrierColor: Colors.black.withOpacity(0.4),
      context: context,
      builder: (context) => Theme(
        data: OrbTheme().getThemeMode,
        child: OrbBottomSheet(
          items: items,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 8,
      ),
      child: CupertinoActionSheet(
        actions: [
          for (var item in items)
            Container(
              child: CupertinoActionSheetAction(
                onPressed: () async{
                  item.onPressed?.call().whenComplete(() => Navigator.pop(context));
                },
                child: Text(
                  item.title,
                  style: themeData.textTheme.bodyMedium?.copyWith(
                    color: item.color,
                  ),
                ),
              ),
            ),
        ],
        cancelButton: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
          ),
          child: CupertinoActionSheetAction(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text(
              "취소",
              style: themeData.textTheme.bodyMedium?.copyWith(
                fontWeight: FontWeight.bold,
                color: OrbPalette.subColor,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
