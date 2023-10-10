import 'package:flutter/material.dart';

class PetitionStatusBar extends StatelessWidget {
  final int selectedIndex;
  final List<String> status = [
    "청원 중",
    "대기 중",
    "답변 완료",
    "기간 만료",
  ];

  PetitionStatusBar({
    super.key,
    this.selectedIndex = 0,
  });

  @override
  Widget build(BuildContext context) {
    final ThemeData themeData = Theme.of(context);
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          for (int i = 0; i < status.length; i++)
            Container(
              margin: const EdgeInsets.only(right: 16),
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: selectedIndex == i
                    ? themeData.colorScheme.primary
                    : themeData.colorScheme.surface,
              ),
              child: Text(
                status[i],
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: Colors.white,
                    ),
              ),
            ),
        ],
      ),
    );
  }

}
