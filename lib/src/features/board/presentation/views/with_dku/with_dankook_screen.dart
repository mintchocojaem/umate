import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../../design_system/orb/orb.dart';

class WithDankookScreen extends StatefulWidget {
  final StatefulNavigationShell navigationShell;

  const WithDankookScreen({
    super.key,
    required this.navigationShell,
  });

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _WithDankookScreenState();
  }
}

class _WithDankookScreenState extends State<WithDankookScreen>
    with SingleTickerProviderStateMixin {
  late final TabController tabController;

  void _goBranch(int index) {
    widget.navigationShell.goBranch(
      index,
      initialLocation: index == widget.navigationShell.currentIndex,
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    tabController = TabController(length: 4, vsync: this);
    tabController.addListener(() {
      _goBranch(tabController.index);
    });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return OrbScaffold(
      padding: EdgeInsets.zero,
      appBar: OrbAppBar(
        title: "With 단국",
      ),
      body: Column(
        children: [
          OrbTabBar(
            controller: tabController,
            tabs: [
              Tab(
                text: "단혼밥",
              ),
              Tab(
                text: "단터디",
              ),
              Tab(
                text: "단국거래",
              ),
              Tab(
                text: "베어이츠",
              ),
            ],
          ),
          Expanded(
            child: widget.navigationShell,
          ),
        ],
      ),
    );
  }
}
