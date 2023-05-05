import 'package:danvery/ui/pages/main/board/board_page/views/board_page.dart';
import 'package:danvery/ui/pages/main/home_page/views/home_page.dart';
import 'package:danvery/ui/pages/main/my_page/views/mypage_page.dart';
import 'package:danvery/ui/pages/main/timetable_page/views/timetable_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MainPageController extends GetxController{

  final RxInt selectedIndex = 0.obs;

  List<Widget> pages = const[
    HomePage(),
    TimetablePage(),
    BoardPage(),
    MyPagePage()
  ];

}
