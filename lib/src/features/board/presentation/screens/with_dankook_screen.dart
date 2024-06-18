import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../design_system/orb/orb.dart';

class WithDankookScreen extends ConsumerStatefulWidget {
  final StatefulNavigationShell navigationShell;

  const WithDankookScreen({
    super.key,
    required this.navigationShell,
  });

  @override
  ConsumerState<ConsumerStatefulWidget> createState() {
    // TODO: implement createState
    return _WithDankookState();
  }
}

class _WithDankookState extends ConsumerState<WithDankookScreen>
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
        trailing: IconButton(
          icon: const OrbIcon(
            Icons.search,
          ),
          onPressed: () {},
        ),
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
