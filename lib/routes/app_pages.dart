import 'package:danvery/app/bindings/authentication_page_binding.dart';
import 'package:danvery/app/bindings/board_binding.dart';
import 'package:danvery/app/bindings/board_page_binding.dart';
import 'package:danvery/app/bindings/bus_binding.dart';
import 'package:danvery/app/bindings/login_binding.dart';
import 'package:danvery/app/bindings/post_binding.dart';
import 'package:danvery/app/controller/board_page_controller.dart';
import 'package:danvery/app/ui/pages/board/general_board_page.dart';
import 'package:danvery/app/ui/pages/board/post/general_post_page.dart';
import 'package:danvery/app/ui/pages/board/search_baord_page.dart';
import 'package:danvery/app/ui/pages/board/board_page.dart';
import 'package:danvery/app/ui/pages/home/home_page.dart';
import 'package:danvery/app/ui/pages/login/authentication_page.dart';
import 'package:danvery/app/ui/pages/mypage/mypage_page.dart';
import 'package:danvery/app/ui/pages/splash/splash_screen.dart';
import 'package:danvery/app/ui/pages/timetable/timetable_page.dart';
import 'package:danvery/routes/app_routes.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get_navigation/src/routes/get_route.dart';
import '../app/bindings/main_binding.dart';
import '../app/bindings/splash_screen_binding.dart';
import '../app/ui/pages/board/post/post_create_page.dart';
import '../app/ui/pages/login/login_page.dart';
import '../app/ui/pages/login/register_page.dart';
import '../app/ui/pages/main/main_page.dart';

class AppPages {
  static final List<GetPage> pages = [
    GetPage(
      name: Routes.main,
      page: () => const MainPage(),
      bindings: [
        MainBinding(),
        BoardBinding(),
        BoardPageBinding(),
        BusBinding(),
      ],
    ),
    GetPage(
      name: Routes.register,
      page: () => const RegisterPage(),
    ),
    GetPage(
        name: Routes.login,
        page: () => const LoginPage(),
        binding: LoginBinding()),
    GetPage(
        name: Routes.authentication,
        page: () => const AuthenticationPage(),
        binding: AuthenticationPageBinding()),
    GetPage(
      name: Routes.generalBoard,
      page: () => const GeneralBoardPage(),
      binding: BoardBinding(),
    ),
    GetPage(name: Routes.searchBoard, page: () => const SearchBoardPage()),
    GetPage(
        name: Routes.postCreate,
        page: () => const PostCreatePage(),
        bindings: [
          PostBinding(),
        ]),
    GetPage(
        name: Routes.generalPost,
        page: () => const GeneralPostPage(),
        binding: PostBinding()),
    GetPage(name: Routes.home, page: () => const HomePage()),
    GetPage(name: Routes.timetable, page: () => const TimetablePage()),
    GetPage(name: Routes.board, page: () => const BoardPage()),
    GetPage(name: Routes.myPage, page: () => const MyPagePage()),
    GetPage(
        name: Routes.splashScreen,
        page: () => const SplashScreen(),
        bindings: [SplashScreenBinding(), LoginBinding()]),
  ];
}
