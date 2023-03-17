import 'package:danvery/app/bindings/board_binding.dart';
import 'package:danvery/app/bindings/page/board_page_binding.dart';
import 'package:danvery/app/bindings/bus_binding.dart';
import 'package:danvery/app/bindings/login_binding.dart';
import 'package:danvery/app/bindings/post_binding.dart';
import 'package:danvery/app/bindings/register_binding.dart';
import 'package:danvery/app/bindings/sms_auth_binding.dart';
import 'package:danvery/app/ui/pages/board/general_board_page.dart';
import 'package:danvery/app/ui/pages/board/search_baord_page.dart';
import 'package:danvery/routes/app_routes.dart';
import 'package:get/get_navigation/src/routes/get_route.dart';

import '../app/bindings/page/main_page_binding.dart';
import '../app/bindings/page/post_page_binding.dart';
import '../app/bindings/page/register_page_binding.dart';
import '../app/bindings/page/splash_screen_page_binding.dart';
import '../app/ui/pages/login/login_page.dart';
import '../app/ui/pages/login/register_page.dart';
import '../app/ui/pages/main/main_page.dart';
import '../app/ui/pages/post/post_create_page.dart';
import '../app/ui/pages/post/post_page.dart';
import '../app/ui/pages/splash/splash_screen_page.dart';

class AppPages {
  static final List<GetPage> pages = [
    GetPage(
      name: Routes.main,
      page: () => const MainPage(),
      bindings: [
        MainPageBinding(),
        BoardBinding(),
        BoardPageBinding(),
        BusBinding(),
      ],
    ),
    GetPage(name: Routes.register, page: () => const RegisterPage(), bindings: [
      RegisterPageBinding(),
      RegisterBinding(),
      SMSAuthBinding(),
    ]),
    GetPage(
        name: Routes.login,
        page: () => const LoginPage(),
        binding: LoginBinding()
    ),
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
        name: Routes.post,
        page: () => const PostPage(),
        bindings: [PostBinding(), PostPageBinding()],
    ),
    GetPage(
        name: Routes.splashScreen,
        page: () => const SplashScreenPage(),
        bindings: [SplashScreenPageBinding()]),
  ];
}
