import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ImageShowPageController extends GetxController {
  final RxList<File> imageList = <File>[].obs;
  final imageIndex = 0.obs;
  final pageController = PageController(initialPage: Get.arguments["index"]);

  @override
  void onInit() {
    Get.arguments["imagePathList"].map((e) => imageList.add(File(e))).toList();
    imageIndex.value = Get.arguments["index"];
    super.onInit();
  }
}
