import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'router_service.dart';
import '../../../design_system/orb/orb.dart';

class BoardScreen extends ConsumerStatefulWidget {
  final StatefulNavigationShell navigationShell;

  const BoardScreen({
    super.key,
    required this.navigationShell,
  });

  @override
  ConsumerState<ConsumerStatefulWidget> createState() {
    // TODO: implement createState
    return _BoardScreenState();
  }
}

class _BoardScreenState extends ConsumerState<BoardScreen>
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
    tabController = TabController(length: 3, vsync: this);
    tabController.addListener(() {
      _goBranch(tabController.index);
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return OrbScaffold(
      padding: EdgeInsets.zero,
      appBar: OrbAppBar(
        title: "총학생회",
        trailing: IconButton(
          icon: const OrbIcon(
            Icons.search,
          ),
          onPressed: () {
            ref.read(routerServiceProvider).pushNamed(
                  AppRoute.postSearch.name,
                );
          },
        ),
      ),
      body: Column(
        children: [
          OrbTabBar(
            controller: tabController,
            tabs: [
              Tab(
                text: "공지사항",
              ),
              Tab(
                text: "제휴사업",
              ),
              Tab(
                text: "청원게시판",
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
