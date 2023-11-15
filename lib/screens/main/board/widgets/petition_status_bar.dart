import 'package:flutter/material.dart';

import '../../../../domain/domain.dart';


class PetitionStatusBar extends StatefulWidget{

  final List<PetitionStatus> status = [
    const PetitionStatus.active(),
    const PetitionStatus.waiting(),
    const PetitionStatus.answered(),
    const PetitionStatus.expired(),
  ];
  final void Function(PetitionStatus) onSelected;

  PetitionStatusBar({
    super.key,
    required this.onSelected,
  });

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _PetitionStatusBar();
  }

}

class _PetitionStatusBar extends State<PetitionStatusBar> {

  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    final ThemeData themeData = Theme.of(context);
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          for (int i = 0; i < widget.status.length; i++)
            InkWell(
              onTap: () {
                setState(() {
                  selectedIndex = i;
                });
                widget.onSelected(widget.status[i]);
              },
              child: Container(
                margin: const EdgeInsets.only(right: 16),
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: selectedIndex == i
                      ? themeData.colorScheme.primary
                      : themeData.colorScheme.surface,
                ),
                child: Text(
                  widget.status[i].name,
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
