import 'package:danvery/app/ui/pages/main/screen/board_screen.dart';
import 'package:danvery/app/ui/pages/main/screen/setting_screen.dart';
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
      SettingScreen()
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
              items: const [
                BottomNavigationBarItem(
                  icon: Icon(Icons.home),
                  label: "홈",
                ),
                BottomNavigationBarItem(
                    icon: Icon(Icons.calendar_today), label: "시간표"),
                BottomNavigationBarItem(
                    icon: Icon(Icons.event_note_outlined), label: "게시판"),
                BottomNavigationBarItem(
                    icon: Icon(Icons.settings), label: "설정"),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
