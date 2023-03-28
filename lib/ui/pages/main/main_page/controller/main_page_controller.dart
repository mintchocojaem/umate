import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../board/board_page/views/board_page.dart';
import '../../home_page/views/home_page.dart';
import '../../my_page/views/mypage_page.dart';
import '../../timetable_page/views/timetable_page.dart';

class MainPageController extends GetxController{

  final RxInt selectedIndex = 0.obs;

  List<Widget> pages = const[
    HomePage(),
    TimetablePage(),
    BoardPage(),
    MyPagePage()
  ];

}
