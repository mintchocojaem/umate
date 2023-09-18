import 'package:flutter/material.dart';

typedef OnIndexChanged = void Function(int index);

class OrbBottomNavigationBar extends StatefulWidget {
  final List<BottomNavigationBarItem> items;
  final OnIndexChanged? onIndexChanged;

  const OrbBottomNavigationBar({
    Key? key,
    required this.items,
    this.onIndexChanged,
  }) : super(key: key);

  @override
  State<OrbBottomNavigationBar> createState() => _OrbBottomNavigationBar();
}

class _OrbBottomNavigationBar extends State<OrbBottomNavigationBar> {
  int selectedIndex = 0;

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
            showSelectedLabels: false,
            showUnselectedLabels: false,
            type: BottomNavigationBarType.fixed,
            onTap: (value) => setState(() {
              selectedIndex = value;
              widget.onIndexChanged?.call(value);
            }),
            currentIndex: selectedIndex,
            items: widget.items,
          ),
        ),
      ),
    );
  }
}
