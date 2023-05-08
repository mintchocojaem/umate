import 'package:danvery/core/theme/app_text_theme.dart';
import 'package:danvery/core/theme/palette.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controller/main_page_controller.dart';

class MainPage extends GetView<MainPageController> {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        final timelapse = DateTime.now().difference(controller.preBackpressure);
        final cantExit = timelapse >= const Duration(seconds: 2);
        controller.preBackpressure = DateTime.now();
        if (cantExit) {
          //show snackbar
          const snack = SnackBar(
            content: Text('앱을 종료하려면 한번 더 눌러주세요'),
            duration: Duration(seconds: 2),
          );
          ScaffoldMessenger.of(context).showSnackBar(snack);
          return false;
        } else {
          return true;
        }
      },
      child: Scaffold(
        backgroundColor: Palette.pureWhite,
        body: Obx(
          () => controller.pages[controller.selectedIndex.value],
        ),
        bottomNavigationBar: Obx(
          () => Container(
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                  topRight: Radius.circular(10), topLeft: Radius.circular(10)),
              boxShadow: [
                BoxShadow(
                    color: Colors.black12, spreadRadius: 1, blurRadius: 2),
              ],
            ),
            child: ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(10.0),
                topRight: Radius.circular(10.0),
              ),
              child: Theme(
                data: ThemeData(
                  splashColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                ),
                child: BottomNavigationBar(
                  selectedFontSize: tinyStyle.fontSize!,
                  unselectedFontSize: tinyStyle.fontSize!,
                  selectedItemColor: Palette.blue,
                  currentIndex: controller.selectedIndex.value,
                  onTap: (value) {
                    controller.selectedIndex.value = value;
                    if(value == 3) controller.loginService.getUserInfo();
                  },
                  type: BottomNavigationBarType.fixed,
                  showSelectedLabels: true,
                  showUnselectedLabels: true,
                  items: [
                    BottomNavigationBarItem(
                      icon: Padding(
                        padding: const EdgeInsets.only(top: 4.0, bottom: 4.0),
                        child: Image.asset(
                          "assets/icons/bottom_navigation_bar/unselected/home_unselected.png",
                          width: 20,
                          height: 20,
                        ),
                      ),
                      activeIcon: Padding(
                        padding: const EdgeInsets.only(top: 4.0, bottom: 4.0),
                        child: Image.asset(
                          "assets/icons/bottom_navigation_bar/selected/home_selected.png",
                          width: 20,
                          height: 20,
                        ),
                      ),
                      label: "홈",
                    ),
                    BottomNavigationBarItem(
                        icon: Padding(
                          padding: const EdgeInsets.only(top: 4.0, bottom: 4.0),
                          child: Image.asset(
                            "assets/icons/bottom_navigation_bar/unselected/timetable_unselected.png",
                            width: 20,
                            height: 20,
                          ),
                        ),
                        activeIcon: Padding(
                          padding: const EdgeInsets.only(top: 4.0, bottom: 4.0),
                          child: Image.asset(
                            "assets/icons/bottom_navigation_bar/selected/timetable_selected.png",
                            width: 20,
                            height: 20,
                          ),
                        ),
                        label: "시간표"),
                    BottomNavigationBarItem(
                        icon: Padding(
                          padding: const EdgeInsets.only(top: 4.0, bottom: 4.0),
                          child: Image.asset(
                            "assets/icons/bottom_navigation_bar/unselected/board_unselected.png",
                            width: 20,
                            height: 20,
                          ),
                        ),
                        activeIcon: Padding(
                          padding: const EdgeInsets.only(top: 4.0, bottom: 4.0),
                          child: Image.asset(
                            "assets/icons/bottom_navigation_bar/selected/board_selected.png",
                            width: 20,
                            height: 20,
                          ),
                        ),
                        label: "게시판"),
                    BottomNavigationBarItem(
                        icon: Padding(
                          padding: const EdgeInsets.only(top: 4.0, bottom: 4.0),
                          child: Image.asset(
                            "assets/icons/bottom_navigation_bar/unselected/my_unselected.png",
                            width: 20,
                            height: 20,
                          ),
                        ),
                        activeIcon: Padding(
                          padding: const EdgeInsets.only(top: 4.0, bottom: 4.0),
                          child: Image.asset(
                            "assets/icons/bottom_navigation_bar/selected/my_selected.png",
                            width: 20,
                            height: 20,
                          ),
                        ),
                        label: "마이페이지"),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
