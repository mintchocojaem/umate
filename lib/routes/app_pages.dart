
import 'package:danvery/domain/bus/binding/bus_binding.dart';
import 'package:danvery/routes/app_routes.dart';
import 'package:danvery/ui/pages/auth/login_page/binding/login_page_binding.dart';
import 'package:danvery/ui/pages/auth/login_page/views/login_page.dart';
import 'package:danvery/ui/pages/auth/register_page/binding/register_page_binding.dart';
import 'package:danvery/ui/pages/auth/register_page/views/register_page.dart';
import 'package:danvery/ui/pages/main/board/board_page/binding/board_page_binding.dart';
import 'package:danvery/ui/pages/main/board/post_page/binding/post_page_binding.dart';
import 'package:danvery/ui/pages/main/board/post_page/views/post_create_page.dart';
import 'package:danvery/ui/pages/main/board/post_page/views/post_page.dart';
import 'package:danvery/ui/pages/main/home_page/binding/home_page_binding.dart';
import 'package:danvery/ui/pages/main/main_page/binding/main_page_binding.dart';
import 'package:danvery/ui/pages/main/main_page/views/main_page.dart';
import 'package:danvery/ui/pages/main/my_page/binding/mypage_page_binding.dart';
import 'package:danvery/ui/pages/main/timetable_page/binding/timetable_page_binding.dart';
import 'package:danvery/ui/pages/splash_screen_page/bindings/splash_screen_page_binding.dart';
import 'package:danvery/ui/pages/splash_screen_page/views/splash_screen_page.dart';
import 'package:get/get_navigation/src/routes/get_route.dart';

import '../domain/auth/login/binding/login_binding.dart';
import '../domain/auth/reigster/binding/register_binding.dart';
import '../domain/board/petition/binding/petition_binding.dart';
import '../domain/board/post/binding/post_binding.dart';
import '../ui/pages/main/board/board_page/views/board_page.dart';
import '../ui/pages/main/home_page/views/home_page.dart';
import '../ui/pages/main/my_page/views/mypage_page.dart';
import '../ui/pages/main/timetable_page/views/timetable_page.dart';

class AppPages {
  static final List<GetPage> pages = [
    GetPage(
      name: Routes.main,
      page: () => const MainPage(),
      bindings: [
        MainPageBinding(),
        HomePageBinding(),
        PostBinding(),
        PetitionBinding(),
        BusBinding(),
        TimetablePageBinding(),
        BoardPageBinding(),
        MyPagePageBinding(),
      ],
    ),
    GetPage(
      name: Routes.postCreate,
      page: () => const PostCreatePage(),
    ),
    GetPage(
      name: Routes.post,
      page: () => const PostPage(),
      bindings: [
        PostPageBinding()
      ],
    ),
    GetPage(
        name: Routes.login,
        page: () => const LoginPage(),
        bindings: [
          LoginBinding(),
          LoginPageBinding(),
        ],
    ),
    GetPage(
      name: Routes.register,
      page: () => const RegisterPage(),
      bindings: [
        RegisterPageBinding(),
        RegisterBinding(),
      ],
    ),
    GetPage(
        name: Routes.splashScreen,
        page: () => const SplashScreenPage(),
        bindings: [
          SplashScreenPageBinding()
        ]
    ),
  ];
}
