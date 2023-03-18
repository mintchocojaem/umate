
import 'package:danvery/utils/theme/app_text_theme.dart';
import 'package:danvery/utils/theme/palette.dart';
import 'package:danvery/ui/pages/main/board/board_page/views/board_page.dart';
import 'package:danvery/ui/pages/main/timetable_page/views/timetable_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../home_page/views/home_page.dart';
import '../../my_page/views/mypage_page.dart';
import '../controller/main_page_controller.dart';

class MainPage extends GetView {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context) {
    final MainPageController mainController = Get.find<MainPageController>();

    List<Widget> pages = const[
      HomePage(),
      TimetablePage(),
      BoardPage(),
      MyPagePage()
    ];

    return Scaffold(
      backgroundColor: Palette.pureWhite,
      body: Obx(() => pages[mainController.selectedIndex]),
      bottomNavigationBar: Obx(
        () => Container(
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.only(
                topRight: Radius.circular(10), topLeft: Radius.circular(10)),
            boxShadow: [
              BoxShadow(color: Colors.black12, spreadRadius: 1, blurRadius: 2),
            ],
          ),
          child: ClipRRect(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(10.0),
              topRight: Radius.circular(10.0),
            ),
            child: BottomNavigationBar(
              selectedFontSize: tinyStyle.fontSize!,
              unselectedFontSize: tinyStyle.fontSize!,
              selectedItemColor: Palette.blue,
              currentIndex: mainController.selectedIndex,
              onTap: (value) {
                mainController.selectedIndex = value;
              },
              type: BottomNavigationBarType.fixed,
              showSelectedLabels: true,
              showUnselectedLabels: true,
              items: [
                BottomNavigationBarItem(
                  icon: Padding(
                    padding: const EdgeInsets.only(top: 4.0, bottom: 4.0),
                    child: Image.asset("assets/icons/bottom_navigation_bar/unselected/home_unselected.png", width: 20, height: 20,),
                  ),
                  activeIcon: Padding(
                    padding: const EdgeInsets.only(top: 4.0, bottom: 4.0),
                    child: Image.asset("assets/icons/bottom_navigation_bar/selected/home_selected.png", width: 20, height: 20,),
                  ),
                  label: "홈",
                ),
                BottomNavigationBarItem(
                    icon: Padding(
                      padding: const EdgeInsets.only(top: 4.0 , bottom: 4.0),
                      child: Image.asset("assets/icons/bottom_navigation_bar/unselected/timetable_unselected.png", width: 20, height: 20,),
                    ),
                    activeIcon: Padding(
                      padding:  const EdgeInsets.only(top: 4.0, bottom: 4.0),
                      child: Image.asset("assets/icons/bottom_navigation_bar/selected/timetable_selected.png", width: 20, height: 20,),
                    ),
                    label: "시간표"),
                BottomNavigationBarItem(
                    icon: Padding(
                      padding: const EdgeInsets.only(top: 4.0, bottom: 4.0),
                      child: Image.asset("assets/icons/bottom_navigation_bar/unselected/board_unselected.png", width: 20, height: 20,),
                    ),
                    activeIcon: Padding(
                      padding: const EdgeInsets.only(top: 4.0, bottom: 4.0),
                      child: Image.asset("assets/icons/bottom_navigation_bar/selected/board_selected.png", width: 20, height: 20,),
                    ),
                    label: "게시판"),
                BottomNavigationBarItem(
                    icon: Padding(
                      padding: const EdgeInsets.only(top: 4.0, bottom: 4.0),
                      child: Image.asset("assets/icons/bottom_navigation_bar/unselected/my_unselected.png", width: 20, height: 20,),
                    ),
                    activeIcon: Padding(
                      padding: const EdgeInsets.only(top: 4.0, bottom: 4.0),
                      child: Image.asset("assets/icons/bottom_navigation_bar/selected/my_selected.png", width: 20, height: 20,),
                    ),
                    label: "마이페이지"),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
