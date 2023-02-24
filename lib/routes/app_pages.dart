import 'package:danvery/app/ui/pages/home_page.dart';
import 'package:danvery/app/ui/pages/free_board_page.dart';
import 'package:danvery/app/ui/pages/petition_board_page.dart';
import 'package:danvery/routes/app_routes.dart';
import 'package:get/get_navigation/src/routes/get_route.dart';

import '../app/bindings/home_binding.dart';
import '../app/ui/pages/timetable_page.dart';

class AppPages {
  static final List<GetPage> pages = [
    GetPage(
      name: Routes.home,
      page: () => const HomePage(),
      binding: HomeBinding(),
      //transition: Transition.fadeIn,
    ),
    //get timetable page
    GetPage(
      name: Routes.timetable,
      page: () => const TimetablePage(),
    ),
    GetPage(
      name: Routes.freeBoard,
      page: () => const FreeBoardPage(),
    ),
    GetPage(
      name: Routes.petitionBoard,
      page: () => const PetitionBoardPage(),
    ),
  ];
}
