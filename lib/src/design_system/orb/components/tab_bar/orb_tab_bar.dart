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
    final themeData = OrbThemeData.of(context);
    final palette = themeData.palette;
    return DefaultTabController(
      length: tabs.length,
      child: TabBar(
        tabs: tabs,
        controller: controller,
        indicatorWeight: 3,
        indicatorColor: palette.primary,
        labelColor: palette.primary,
        onTap: onTabChange,
      ),
    );
  }
}
