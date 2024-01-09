import 'package:flutter/material.dart';

import '../../../../domain/domain.dart';

class PetitionStatusBar extends StatelessWidget {

  final PetitionStatus currentStatus;

  final List<PetitionStatus> status = [
    const PetitionStatus.active(),
    const PetitionStatus.waiting(),
    const PetitionStatus.answered(),
    const PetitionStatus.expired(),
  ];

  final void Function(PetitionStatus) onSelected;

  PetitionStatusBar({super.key, required this.currentStatus, required this.onSelected});

  @override
  Widget build(BuildContext context) {
    final ThemeData themeData = Theme.of(context);
    int selectedIndex = status.indexOf(currentStatus);
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          for (int i = 0; i < status.length; i++)
            InkWell(
              onTap: () {
                selectedIndex = i;
                onSelected(status[i]);
              },
              child: Container(
                margin: const EdgeInsets.only(right: 16,),
                padding: const EdgeInsets.only(left: 16, right: 16, top: 8, bottom: 8),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: selectedIndex == i
                      ? themeData.colorScheme.primary
                      : themeData.colorScheme.surfaceVariant,
                ),
                child: Text(
                  status[i].name,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: selectedIndex == i
                        ? themeData.colorScheme.onPrimary
                        : themeData.colorScheme.onSurface,
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }

}
