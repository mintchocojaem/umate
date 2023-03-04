import 'package:danvery/app/ui/pages/main/screen/board_screen.dart';
import 'package:danvery/app/ui/pages/main/screen/setting_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controller/main_controller.dart';
import 'screen/home_screen.dart';
import 'screen/timetable_screen.dart';

class MainPage extends GetView{
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

    return SafeArea(
      child: Scaffold(
        body: Padding(
            padding: const EdgeInsets.only(bottom: 60),
            child: Obx(() => pages[mainController.selectedIndex])),
        bottomNavigationBar: Container(
          height: 60,
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.only(
                topRight: Radius.circular(20), topLeft: Radius.circular(20)),
            boxShadow: [
              BoxShadow(color: Colors.black38, spreadRadius: 0, blurRadius: 1),
            ],
          ),
          child: ClipRRect(
              borderRadius: const BorderRadius.only(
                  topRight: Radius.circular(20), topLeft: Radius.circular(20)),
              child: Obx(
                    () => BottomNavigationBar(
                  currentIndex:mainController.selectedIndex,
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
              )),
        ),
        extendBody: true,
      ),
    );
  }
}
