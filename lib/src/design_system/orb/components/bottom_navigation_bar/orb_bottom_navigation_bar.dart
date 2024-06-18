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
    final theme = OrbThemeData.of(context);
    final palette = theme.palette;
    return Container(
      decoration: BoxDecoration(
        color: Colors.transparent,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
        boxShadow: [
          BoxShadow(
            color: palette.shadow,
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
          color: palette.background,
          child: SafeArea(
            child: Row(
              children: items
                  .map(
                    (e) => Expanded(
                      child: IconButton(
                        style: ButtonStyle(
                          overlayColor: WidgetStateProperty.all(
                            Colors.transparent,
                          ),
                        ),
                        icon: e.icon,
                        color: currentIndex == items.indexOf(e)
                            ? palette.primary
                            : palette.surface,
                        onPressed: () {
                          onIndexChanged?.call(items.indexOf(e));
                        },
                      ),
                    ),
                  )
                  .toList(),
            ),
          ),
        ),
      ),
    );
  }
}
