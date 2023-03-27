import 'package:danvery/ui/pages/main/board/board_page/controller/board_page_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PostSearchPageController extends GetxController{

  final TextEditingController searchController = TextEditingController();

  final BoardPageController boardPageController = Get.find<BoardPageController>();

  @override
  void onInit() {
    super.onInit();
    searchController.addListener(() {
      boardPageController.searchText = searchController.text;
    });
  }

}
