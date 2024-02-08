import 'package:flutter/material.dart';

import '../../theme/theme.dart';


typedef OnIndexChanged = void Function(int index);

class OrbBottomNavigationBar extends StatelessWidget {

  final List<BottomNavigationBarItem> items;
  final OnIndexChanged? onIndexChanged;
  final int? currentIndex;

  const OrbBottomNavigationBar({
    super.key,
    required this.items,
    this.onIndexChanged,
    this.currentIndex,
  });

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return Container(
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.only(
          topRight: Radius.circular(20),
          topLeft: Radius.circular(20),
        ),
        boxShadow: [
          BoxShadow(
            color: theme.colorScheme.onSurface,
            spreadRadius: 0,
            blurRadius: 1,
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
        child: Container(
          decoration: BoxDecoration(
            color: theme.colorScheme.surface,
            boxShadow: [
              BoxShadow(
                color: theme.colorScheme.onSurface.withOpacity(0.1),
                blurRadius: 10,
              ),
            ],
          ),
          child: BottomNavigationBar(
            backgroundColor: theme.colorScheme.surface,
            showSelectedLabels: false,
            showUnselectedLabels: false,
            type: BottomNavigationBarType.fixed,
            onTap: (value) => onIndexChanged?.call(value),
            currentIndex: currentIndex ?? 0,
            items: items,
            selectedItemColor: OrbPalette.mainColor,
          ),
        ),
      ),
    );
  }
}
