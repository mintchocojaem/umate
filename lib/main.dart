import 'dart:io';

import 'package:danvery/app/bindings/main_binding.dart';
import 'package:danvery/app/controller/login_controller.dart';
import 'package:danvery/app/ui/theme/app_theme.dart';
import 'package:danvery/routes/app_pages.dart';
import 'package:danvery/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import 'app/controller/main_controller.dart';
import 'app/data/model/subject_model.dart';


void main() async {

  WidgetsFlutterBinding.ensureInitialized();

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

class MainPage extends GetView{
  const MainPage({super.key});

  @override
  Widget build(BuildContext context) {

    final MainController mainController = Get.find<MainController>();

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
