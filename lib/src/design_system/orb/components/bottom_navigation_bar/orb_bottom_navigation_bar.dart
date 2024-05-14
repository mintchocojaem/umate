import 'package:flutter/material.dart';

import '../../theme/orb_theme.dart';

typedef OnIndexChanged = void Function(int index);

class OrbBottomNavigationBarItem {
  final Widget icon;
  final String label;

  const OrbBottomNavigationBarItem({
    required this.icon,
    required this.label,
  });

  BottomNavigationBarItem toBottomNavigationBarItem() {
    return BottomNavigationBarItem(
      icon: icon,
      label: label,
    );
  }
}

class OrbBottomNavigationBar extends StatelessWidget {
  final List<OrbBottomNavigationBarItem> items;
  final OnIndexChanged? onIndexChanged;
  final int? currentIndex;

  const OrbBottomNavigationBar({
    super.key,
    required this.items,
    this.onIndexChanged,
    this.currentIndex,
  });

  @override
  build(BuildContext context) {
    final theme = OrbTheme.of(context);
    final currentPalette = theme.getCurrentPalette(context);
    return Container(
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.only(
          topRight: Radius.circular(20),
          topLeft: Radius.circular(20),
        ),
        boxShadow: [
          BoxShadow(
            color: theme.bottomNavigationBarTheme.borderColor,
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
            color: theme.bottomNavigationBarTheme.backgroundColor,
            boxShadow: [
              BoxShadow(
                color: theme.bottomNavigationBarTheme.borderColor,
                blurRadius: 10,
              ),
            ],
          ),
          child: BottomNavigationBar(
            backgroundColor: theme
                .bottomNavigationBarTheme.backgroundColor,
            showSelectedLabels: false,
            showUnselectedLabels: false,
            type: BottomNavigationBarType.fixed,
            currentIndex: currentIndex ?? 0,
            selectedItemColor: currentPalette.primary,
            unselectedItemColor: currentPalette.surface,
            onTap: (value) {
              onIndexChanged?.call(value);
            },
            items: items.map((e) => e.toBottomNavigationBarItem()).toList(),
          ),
        ),
      ),
    );
  }
}
