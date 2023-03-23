
import 'package:danvery/domain/board/comment/general_comment/binding/general_comment_binding.dart';
import 'package:danvery/domain/board/post/general_post/binding/post_binding.dart';
import 'package:danvery/domain/bus/binding/bus_binding.dart';
import 'package:danvery/routes/app_routes.dart';
import 'package:danvery/ui/pages/auth/login_page/binding/login_page_binding.dart';
import 'package:danvery/ui/pages/auth/login_page/views/login_page.dart';
import 'package:danvery/ui/pages/auth/register_page/binding/register_page_binding.dart';
import 'package:danvery/ui/pages/auth/register_page/views/register_page.dart';
import 'package:danvery/ui/pages/main/board/board_page/binding/board_page_binding.dart';
import 'package:danvery/ui/pages/main/board/general_post_page/binding/general_post_page_binding.dart';
import 'package:danvery/ui/pages/main/board/general_post_page/views/general_post_create_page.dart';
import 'package:danvery/ui/pages/main/board/general_post_page/views/general_post_page.dart';
import 'package:danvery/ui/pages/main/board/petition_post_page/binding/petition_page_binding.dart';
import 'package:danvery/ui/pages/main/board/petition_post_page/views/petition_page.dart';
import 'package:danvery/ui/pages/main/home_page/binding/home_page_binding.dart';
import 'package:danvery/ui/pages/main/main_page/binding/main_page_binding.dart';
import 'package:danvery/ui/pages/main/main_page/views/main_page.dart';
import 'package:danvery/ui/pages/main/my_page/binding/mypage_page_binding.dart';
import 'package:danvery/ui/pages/main/timetable_page/binding/timetable_page_binding.dart';
import 'package:danvery/ui/pages/splash_screen_page/bindings/splash_screen_page_binding.dart';
import 'package:danvery/ui/pages/splash_screen_page/views/splash_screen_page.dart';
import 'package:danvery/utils/permission/binding/permission_binding.dart';
import 'package:get/get_navigation/src/routes/get_route.dart';

import '../domain/auth/login/binding/login_binding.dart';
import '../domain/auth/reigster/binding/register_binding.dart';
import '../domain/board/post/petition_post/binding/petition_post_binding.dart';
import '../ui/pages/auth/find_password_page/binding/find_password_page_binding.dart';
import '../ui/pages/auth/find_password_page/views/find_password_page.dart';

class AppPages {
  static final List<GetPage> pages = [
    GetPage(
      name: Routes.main,
      page: () => const MainPage(),
      bindings: [
        MainPageBinding(),
        HomePageBinding(),
        TimetablePageBinding(),
        BoardPageBinding(),
        MyPagePageBinding(),
        BusBinding(),
        PostBinding(),
        PetitionBinding(),
        PermissionBinding(),
      ],
    ),
    GetPage(
      name: Routes.postCreate,
      page: () => const GeneralPostCreatePage(),
    ),
    GetPage(
      name: Routes.post,
      page: () => const GeneralPostPage(),
      bindings: [
        GeneralPostPageBinding(),
        GeneralCommentBinding(),
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
      name: Routes.findPassword,
      page: () => const FindPasswordPage(),
      bindings: [
        FindPasswordPageBinding(),
      ],
    ),
    GetPage(
        name: Routes.splashScreen,
        page: () => const SplashScreenPage(),
        bindings: [
          SplashScreenPageBinding()
        ]
    ),
    GetPage(
      name: Routes.petition,
      page: () => const PetitionPostPage(),
      bindings: [
        PetitionBinding(),
        PetitionPostPageBinding()
      ],
    ),
  ];
}
