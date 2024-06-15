import 'package:flutter/material.dart';
import 'package:umate/src/core/utils/extensions.dart';

import '../../../../design_system/orb/orb.dart';

class CategoryBar extends StatefulWidget {
  final int currentIndex;
  final List<String> categoryList;
  final void Function(int index) onIndexChanged;

  const CategoryBar({
    super.key,
    required this.currentIndex,
    required this.categoryList,
    required this.onIndexChanged,
  });

  @override
  State<CategoryBar> createState() => _CategoryBarState();
}

class _CategoryBarState extends State<CategoryBar> {
  int selectedIndex = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    selectedIndex = widget.currentIndex;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 16,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          for (int i = 0; i < widget.categoryList.length; i++)
            InkWell(
              onTap: () {
                if (selectedIndex != i) {
                  setState(() {
                    widget.onIndexChanged(i);
                    selectedIndex = i;
                  });
                }
              },
              child: Container(
                padding: const EdgeInsets.only(
                    left: 16, right: 16, top: 8, bottom: 8),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: selectedIndex == i
                      ? context.palette.primary
                      : context.palette.surfaceBright,
                ),
                child: OrbText(
                  widget.categoryList[i],
                  type: OrbTextType.bodyMedium,
                  color: selectedIndex == i
                      ? context.palette.onPrimary
                      : context.palette.surface,
                ),
              ),
            ),
        ],
      ),
    );
  }
}