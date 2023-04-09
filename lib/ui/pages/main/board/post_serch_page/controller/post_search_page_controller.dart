import 'package:danvery/ui/pages/main/board/board_page/controller/board_page_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PostSearchPageController extends GetxController{

  final TextEditingController searchController = TextEditingController();

  final BoardPageController boardPageController = Get.find();

  Future<void> searchBoard() async{
    if(searchController.text.isNotEmpty){
      boardPageController.searchText.value = searchController.text;
      await boardPageController.getFirstGeneralPostBoard();
      await boardPageController.getFirstPetitionPostBoard();
      Get.back();
    }
  }

}
