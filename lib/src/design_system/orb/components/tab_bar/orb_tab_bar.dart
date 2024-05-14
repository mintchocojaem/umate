import 'package:flutter/material.dart';

import '../../orb.dart';

class OrbTabBar extends StatelessWidget {
  final List<Tab> tabs;
  final TabController? controller;
  final Function(int)? onTabChange;

  const OrbTabBar({
    super.key,
    required this.tabs,
    this.controller,
    this.onTabChange,
  });

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    final theme = OrbTheme.of(context);
    return DefaultTabController(
      length: tabs.length,
      child: TabBar(
        tabs: tabs,
        controller: controller,
        indicatorWeight: 3,
        indicatorColor: theme.tabBarTheme.indicatorColor,
        labelColor: theme.tabBarTheme.indicatorColor,
        onTap: onTabChange,
      ),
    );
  }
}
