import 'package:flutter/material.dart';

class ModernBottomNavigationBar extends StatefulWidget {
  final List<BottomNavigationBarItem> items;

  const ModernBottomNavigationBar({Key? key, required this.items})
      : super(key: key);

  @override
  State<ModernBottomNavigationBar> createState() =>
      _ModernBottomNavigationBar();
}

class _ModernBottomNavigationBar extends State<ModernBottomNavigationBar> {
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return Container(
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.only(
            topRight: Radius.circular(24), topLeft: Radius.circular(24)),
        boxShadow: [
          BoxShadow(
              color: theme.colorScheme.onBackground,
              spreadRadius: 0,
              blurRadius: 1),
        ],
      ),
      child: ClipRRect(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(24.0),
          topRight: Radius.circular(24.0),
        ),
        child: BottomNavigationBar(
          showSelectedLabels: false,
          showUnselectedLabels: false,
          type: BottomNavigationBarType.fixed,
          onTap: (value) => setState(() => selectedIndex = value),
          currentIndex: selectedIndex,
          items: widget.items,
        ),
      ),
    );
  }
}
