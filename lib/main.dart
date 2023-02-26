import 'dart:io';

import 'package:danvery/app/bindings/main_binding.dart';
import 'package:danvery/app/controller/login_controller.dart';
import 'package:danvery/app/ui/theme/app_theme.dart';
import 'package:danvery/routes/app_pages.dart';
import 'package:danvery/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'app/controller/main_controller.dart';
import 'app/data/model/subject_model.dart';
import 'app/data/model/user_model.dart';
import 'app/ui/theme/app_colors.dart';

UserModel userModel = UserModel(subjects: [
  SubjectModel(
      name: "확률과 통계", startTime: '09:00', endTime: '10:30', days: ["월", "화"]),
  SubjectModel(
      name: "선형 대수", startTime: '11:00', endTime: '12:30', days: ["수"]),
], name: "이재민", major: "소프트웨어학과", studentNumber: "32193419");

void main() async {
  runApp(GetMaterialApp(
    initialBinding: MainBinding(),
    initialRoute: Routes.login,
    getPages: AppPages.pages,
    debugShowCheckedModeBanner: false,
    theme: appThemeData,
    darkTheme: ThemeData(
      brightness: Brightness.light,
      /* dark theme settings */
    ),
    themeMode: ThemeMode.light,
    /* ThemeMode.system to follow system theme,
         ThemeMode.light for light theme,
         ThemeMode.dark for dark theme
      */
  ));
}

class MainPage extends StatelessWidget {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context) {
    final AppPages appPages = AppPages();

    List<Widget> pages = [
      appPages.findPage(Routes.home),
      appPages.findPage(Routes.timetable),
      appPages.findPage(Routes.board),
      appPages.findPage(Routes.setting),
    ];

    return SafeArea(
      child: Scaffold(
        body: Padding(
            padding: const EdgeInsets.only(bottom: 60),
            child: Obx(() => pages[MainController.to.selectedIndex])),
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
                  currentIndex: MainController.to.selectedIndex,
                  onTap: (value) {
                    MainController.to.selectedIndex = value;
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
