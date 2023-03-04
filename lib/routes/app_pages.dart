import 'package:danvery/app/bindings/board_binding.dart';
import 'package:danvery/app/bindings/login_binding.dart';
import 'package:danvery/app/bindings/post_binding.dart';
import 'package:danvery/app/ui/pages/board/general_board_page.dart';
import 'package:danvery/app/ui/pages/board/search_baord_page.dart';
import 'package:danvery/routes/app_routes.dart';
import 'package:get/get_navigation/src/routes/get_route.dart';
import '../app/bindings/main_binding.dart';
import '../app/ui/pages/board/post/new_post_page.dart';
import '../app/ui/pages/login/login_page.dart';
import '../app/ui/pages/register/register_page.dart';
import '../app/ui/pages/main/main_page.dart';

class AppPages {
  static final List<GetPage> pages = [
    GetPage(
      name: Routes.main,
      page: () => const MainPage(),
      bindings: [MainBinding(), BoardBinding()],
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
      name: Routes.generalBoard,
      page: () => const GeneralBoardPage(),
    ),
    GetPage(name: Routes.searchBoard,
        page: () => const SearchBoardPage()
    ),
    GetPage(name: Routes.newPost,
        page: () => const NewPostPage(),
        binding: PostBinding()
    ),
  ];
}
