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
    Key? key,
    required this.items,
  }) : super(key: key);

  final List<SheetItem> items;

  Future<void> show(context) async {
    await showCupertinoModalPopup(
      context: context,
      builder: (context) => OrbBottomSheet(
        items: items,
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
            CupertinoActionSheetAction(
              onPressed: () async{
                item.onPressed?.call().whenComplete(() => Navigator.pop(context));
              },
              child: Text(
                item.title,
                style: themeData.textTheme.bodyMedium?.copyWith(
                  color: item.color,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
        ],
        cancelButton: CupertinoActionSheetAction(
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text(
            "취소",
            style: themeData.textTheme.bodyMedium?.copyWith(
              color: themeData.colorScheme.onSurface,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ),
    );
  }
}
