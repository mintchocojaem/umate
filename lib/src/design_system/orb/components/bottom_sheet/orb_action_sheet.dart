import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../orb.dart';

class SheetItem {
  final String title;
  final Color? color;

  SheetItem({
    required this.title,
    this.color,
  });
}

class OrbActionSheet extends StatelessWidget {
  final List<SheetItem> items;
  final void Function(int index) onSelected;

  const OrbActionSheet({
    super.key,
    required this.items,
    required this.onSelected,
  });

  Future<void> show(context) async {
    await showCupertinoModalPopup(
      barrierColor: Colors.black.withOpacity(0.4),
      context: context,
      builder: (context) => OrbActionSheet(
        items: items,
        onSelected: onSelected,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final themeData = OrbThemeData.of(context);
    final palette = themeData.palette;
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 8,
      ),
      child: CupertinoActionSheet(
        actions: [
          for (var item in items)
            CupertinoActionSheetAction(
              onPressed: () {
                Navigator.pop(context);
                onSelected(items.indexOf(item));
              },
              child: OrbText(
                item.title,
                type: OrbTextType.bodyLarge,
                color: item.color ?? palette.error,
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
            child: OrbText(
              "닫기",
              type: OrbTextType.bodyLarge,
              color: palette.primary,
            ),
          ),
        ),
      ),
    );
  }
}
