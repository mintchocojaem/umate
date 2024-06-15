import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../design_system/orb/orb.dart';

class MainScreen extends StatelessWidget {
  final StatefulNavigationShell navigationShell;

  const MainScreen({
    super.key,
    required this.navigationShell,
  });

  void _goBranch(int index) {
    navigationShell.goBranch(
      index,
      initialLocation: index == navigationShell.currentIndex,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: navigationShell,
      bottomNavigationBar: OrbBottomNavigationBar(
        currentIndex: navigationShell.currentIndex,
        onIndexChanged: (index) {
          if (index != navigationShell.currentIndex) {
            _goBranch(index);
          } else {
            //print path
          }
        },
        items: const [
          OrbBottomNavigationBarItem(
            icon: ImageIcon(
              AssetImage("assets/icons/bottom_nav_home.png"),
            ),
            label: "홈",
          ),
          OrbBottomNavigationBarItem(
            icon: ImageIcon(
              AssetImage("assets/icons/bottom_nav_board.png"),
            ),
            label: "게시판",
          ),
          OrbBottomNavigationBarItem(
            icon: ImageIcon(
              AssetImage("assets/icons/bottom_nav_timetable.png"),
            ),
            label: "시간표",
          ),
          OrbBottomNavigationBarItem(
            icon: ImageIcon(
              AssetImage("assets/icons/bottom_nav_profile.png"),
            ),
            label: "내 정보",
          ),
        ],
      ),
    );
  }
}
