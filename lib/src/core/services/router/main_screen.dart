import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import '../../../design_system/orb/components/bottom_navigation_bar/orb_bottom_navigation_bar.dart';
import 'router_service.dart';

@RoutePage()
class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AutoTabsRouter.pageView(
      homeIndex: 0,
      physics: const NeverScrollableScrollPhysics(),
      routes: const [
        //HomeRoute(),
        //PetitionBoardRoute(),
      ],
      builder: (context, child, animation) {
        return Scaffold(
          body: child,
          bottomNavigationBar: OrbBottomNavigationBar(
            currentIndex: context.tabsRouter.activeIndex,
            onIndexChanged: (index) {
              context.tabsRouter.setActiveIndex(index);
            },
            items: const [
              BottomNavigationBarItem(icon: Icon(Icons.home), label: "홈"),
              BottomNavigationBarItem(
                  icon: Icon(Icons.assignment), label: "게시판"),
              BottomNavigationBarItem(
                  icon: Icon(Icons.space_dashboard), label: "시간표"),
              BottomNavigationBarItem(icon: Icon(Icons.person), label: "내 정보"),
            ],
          ),
        );
      },
    );
  }
}
