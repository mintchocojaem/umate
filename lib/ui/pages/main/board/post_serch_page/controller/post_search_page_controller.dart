import 'package:danvery/ui/pages/main/board/board_page/controller/board_page_controller.dart';
import 'package:danvery/ui/pages/main/main_page/controller/main_page_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PostSearchPageController extends GetxController{

  final MainPageController mainPageController = Get.find();

  final TextEditingController searchController = TextEditingController();

  final BoardPageController boardPageController = Get.find();

  Future<void> searchBoard() async{
    if(searchController.text.isNotEmpty){

      showCupertinoModalPopup(
        context: Get.context!,
        builder: (context) => const Center(
          child: CupertinoActivityIndicator(),
        ),
        barrierDismissible: false,
      );

      boardPageController.searchText.value = searchController.text;
      await boardPageController.getGeneralPostBoardWithRefresh(true);
      await boardPageController.getPetitionPostBoardWithRefresh(true);
      Get.back();
      Get.back();
      mainPageController.selectedIndex.value = 2;
      boardPageController.selectedTap.value = 0;
    }
  }

}
