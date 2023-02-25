import 'package:danvery/app/ui/pages/home_page.dart';
import 'package:danvery/app/ui/pages/login_page.dart';
import 'package:danvery/app/ui/pages/register_page.dart';
import 'package:danvery/app/ui/pages/setting_page.dart';
import 'package:danvery/main.dart';
import 'package:danvery/routes/app_routes.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get_navigation/src/routes/get_route.dart';
import '../app/ui/pages/authentication_page.dart';
import '../app/ui/pages/board_page.dart';
import '../app/ui/pages/timetable_page.dart';

class AppPages {

  static final List<GetPage> pages = [
    GetPage(
        name: Routes.main,
        page: () => const MainPage(),
    ),
    GetPage(
      name: Routes.home,
      page: () => const HomePage(),
      //transition: Transition.fadeIn,
    ),
    //get timetable page
    GetPage(
      name: Routes.timetable,
      page: () => const TimetablePage(),
    ),
    GetPage(
      name: Routes.board,
      page: () => const BoardPage(),
    ),
    GetPage(
        name: Routes.authentication,
        page: () => const AuthenticationPage(),
    ),
    GetPage(
        name: Routes.register,
        page: () => const RegisterPage(),
    ),
    GetPage(
        name: Routes.login,
        page: () => const LoginPage()
    ),
    GetPage(
        name: Routes.setting,
        page: () => const SettingPage()
    )
  ];

  Widget findPage(String name) {
    return pages.firstWhere((element) => element.name == name).page();
  }

}
