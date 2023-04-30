import 'package:danvery/routes/app_routes.dart';
import 'package:danvery/service/login/binding/login_binding.dart';
import 'package:danvery/ui/pages/banner_list/binding/banner_list_page_binding.dart';
import 'package:danvery/ui/pages/banner_list/views/banner_detail_page.dart';
import 'package:danvery/ui/pages/banner_list/views/banner_list_page.dart';
import 'package:danvery/ui/pages/main/board/iamge_show_page/binding/image_show_page_binding.dart';
import 'package:danvery/ui/pages/main/board/iamge_show_page/views/image_show_page.dart';
import 'package:danvery/ui/pages/main/board/petition_post_page/views/petition_agree_status_page.dart';
import 'package:danvery/ui/pages/main/board/petition_post_write_page/binding/petition_post_write_page_binding.dart';
import 'package:danvery/ui/pages/main/board/petition_post_write_page/views/petition_post_write_page.dart';
import 'package:danvery/ui/pages/main/my_page/views/mypage_edit_page.dart';
import 'package:danvery/ui/pages/main/my_page/views/mypage_post_page.dart';
import 'package:danvery/ui/pages/user/find_id_page/binding/find_id_page_binding.dart';
import 'package:danvery/ui/pages/user/find_id_page/views/find_id_page.dart';
import 'package:danvery/ui/pages/user/find_password_page/binding/find_password_page_binding.dart';
import 'package:danvery/ui/pages/user/find_password_page/views/find_password_page.dart';
import 'package:danvery/ui/pages/user/login_page/binding/login_page_binding.dart';
import 'package:danvery/ui/pages/user/login_page/views/login_page.dart';
import 'package:danvery/ui/pages/user/register_page/binding/register_page_binding.dart';
import 'package:danvery/ui/pages/user/register_page/views/register_page.dart';
import 'package:danvery/ui/pages/main/board/board_page/binding/board_page_binding.dart';
import 'package:danvery/ui/pages/main/board/general_post_page/binding/general_post_page_binding.dart';
import 'package:danvery/ui/pages/main/board/general_post_write_page/binding/general_post_write_page_binding.dart';
import 'package:danvery/ui/pages/main/board/general_post_write_page/views/general_post_write_page.dart';
import 'package:danvery/ui/pages/main/board/general_post_page/views/general_post_page.dart';
import 'package:danvery/ui/pages/main/board/petition_post_page/binding/petition_post_page_binding.dart';
import 'package:danvery/ui/pages/main/board/petition_post_page/views/petition_post_page.dart';
import 'package:danvery/ui/pages/main/board/post_serch_page/binding/post_search_page_binding.dart';
import 'package:danvery/ui/pages/main/board/post_serch_page/views/post_search_page.dart';
import 'package:danvery/ui/pages/main/home_page/binding/home_page_binding.dart';
import 'package:danvery/ui/pages/main/main_page/binding/main_page_binding.dart';
import 'package:danvery/ui/pages/main/main_page/views/main_page.dart';
import 'package:danvery/ui/pages/main/my_page/binding/mypage_page_binding.dart';
import 'package:danvery/ui/pages/main/timetable_page/binding/timetable_page_binding.dart';
import 'package:danvery/ui/pages/splash_screen_page/bindings/splash_screen_page_binding.dart';
import 'package:danvery/ui/pages/splash_screen_page/views/splash_screen_page.dart';
import 'package:danvery/service/permission/binding/permission_binding.dart';
import 'package:get/get_navigation/src/routes/get_route.dart';

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
        PermissionBinding(),
        MyPagePageBinding(),
      ],
    ),
    GetPage(
      name: Routes.generalPostWrite,
      page: () => const GeneralPostWritePage(),
      bindings: [
        GeneralPostWritePageBinding(),
      ],
    ),
    GetPage(
      name: Routes.petitionPostWrite,
      page: () => const PetitionPostWritePage(),
      bindings: [
        PetitionPostWritePageBinding(),
      ],
    ),
    GetPage(
      name: Routes.post,
      page: () => const GeneralPostPage(),
      bindings: [
        GeneralPostPageBinding(),
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
      ],
    ),
    GetPage(
      name: Routes.findId,
      page: () => const FindIdPage(),
      bindings: [
        FindIdPageBinding(),
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
        bindings: [SplashScreenPageBinding(), LoginBinding()]),
    GetPage(
      name: Routes.petition,
      page: () => const PetitionPostPage(),
      bindings: [PetitionPostPageBinding()],
    ),
    GetPage(
      name: Routes.postSearch,
      page: () => const PostSearchPage(),
      bindings: [PostSearchPageBinding()],
    ),
    GetPage(
      name: Routes.imageShow,
      page: () => const ImageShowPage(),
      bindings: [
        ImageShowPageBinding(),
      ],
    ),
    GetPage(
      name: Routes.petitionAgreeStatus,
      page: () => const PetitionAgreeStatusPage(),
    ),
    GetPage(
      name: Routes.myPageEdit,
      page: () => const MyPageEditPage(),
    ),
    GetPage(
      name: Routes.banner,
      page: () => const BannerListPage(),
    ),
    GetPage(
      name: Routes.bannerDetail,
      page: () => const BannerDetailPage(),
      bindings: [
        BannerListPageBinding(),
      ]
    ),
    GetPage(
      name: Routes.myPagePost,
      page: () => const MyPagePostPage(),
    ),
  ];
}
