import 'package:danvery/app/ui/pages/main/screen/board_screen.dart';
import 'package:danvery/app/ui/pages/main/screen/mypage_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controller/main_controller.dart';
import '../../theme/app_colors.dart';
import 'screen/home_screen.dart';
import 'screen/timetable_screen.dart';

class MainPage extends GetView {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context) {
    final MainController mainController = Get.find<MainController>();

    List<Widget> pages = const[
      HomeScreen(),
      TimetableScreen(),
      BoardScreen(),
      MyPageScreen()
    ];

    return Scaffold(
      backgroundColor: white,
      body: Obx(() => pages[mainController.selectedIndex]),
      bottomNavigationBar: Obx(
        () => Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
                topRight: Radius.circular(30), topLeft: Radius.circular(30)),
            boxShadow: [
              BoxShadow(color: Colors.black38, spreadRadius: 0, blurRadius: 3),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30.0),
              topRight: Radius.circular(30.0),
            ),
            child: BottomNavigationBar(
              currentIndex: mainController.selectedIndex,
              onTap: (value) {
                mainController.selectedIndex = value;
              },
              type: BottomNavigationBarType.fixed,
              showSelectedLabels: false,
              showUnselectedLabels: false,
              items: [
                BottomNavigationBarItem(
                  icon: Image.asset("assets/icons/bottom_navigation_bar/unselected/home_unselected.png", width: 24, height: 24,),
                  activeIcon: Image.asset("assets/icons/bottom_navigation_bar/selected/home_selected.png", width: 24, height: 24,),
                  label: "홈",
                ),
                BottomNavigationBarItem(
                    icon: Image.asset("assets/icons/bottom_navigation_bar/unselected/timetable_unselected.png", width: 24, height: 24,),
                    activeIcon: Image.asset("assets/icons/bottom_navigation_bar/selected/timetable_selected.png", width: 24, height: 24,),
                    label: "시간표"),
                BottomNavigationBarItem(
                    icon: Image.asset("assets/icons/bottom_navigation_bar/unselected/board_unselected.png", width: 24, height: 24,),
                    activeIcon: Image.asset("assets/icons/bottom_navigation_bar/selected/board_selected.png", width: 24, height: 24,),
                    label: "게시판"),
                BottomNavigationBarItem(
                    icon: Image.asset("assets/icons/bottom_navigation_bar/unselected/my_unselected.png", width: 24, height: 24,),
                    activeIcon: Image.asset("assets/icons/bottom_navigation_bar/selected/my_selected.png", width: 24, height: 24,),
                    label: "마이"),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
