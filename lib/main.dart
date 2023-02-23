import 'package:danvery/app/bindings/home_binding.dart';
import 'package:danvery/app/bindings/main_binding.dart';
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
    initialBinding: BindingsBuilder(() {
      MainBinding().dependencies();
      HomeBinding().dependencies();
    }),
    home: const MyApp(),
    initialRoute: Routes.main,
    getPages: AppPages.pages,
    debugShowCheckedModeBanner: false,
    themeMode: ThemeMode.light,
    theme: appThemeData,
  ));
}

class MyApp extends GetView<MainController> {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: white,
        body: Padding(
          padding: const EdgeInsets.only(bottom: 60),
          child: Obx(() => controller.isLogin
              ? AppPages.pages[controller.selectedIndex].page()
              : const Center(
                child: CircularProgressIndicator(),
              )),
        ),
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
            child: BottomNavigationBar(
              onTap: (value) {
                controller.selectedIndex = value;
              },
              backgroundColor: white,
              showSelectedLabels: false,
              showUnselectedLabels: false,
              items: [
                BottomNavigationBarItem(
                  icon: Image.asset(
                    "assets/icons/bottom_nav/home_icon.png",
                    scale: 2,
                  ),
                  label: "홈",
                ),
                BottomNavigationBarItem(
                    icon: Image.asset(
                        "assets/icons/bottom_nav/timetable_icon.png",
                        scale: 2),
                    label: "시간표"),
                BottomNavigationBarItem(
                    icon: Image.asset("assets/icons/bottom_nav/bus_icon.png",
                        scale: 2),
                    label: "버스"),
                BottomNavigationBarItem(
                    icon: Image.asset("assets/icons/bottom_nav/board_icon.png",
                        scale: 2),
                    label: "게시판"),
                BottomNavigationBarItem(
                    icon: Image.asset(
                        "assets/icons/bottom_nav/setting_icon.png",
                        scale: 2),
                    label: "설정"),
              ],
            ),
          ),
        ),
        extendBody: true,
      ),
    );
  }
}
