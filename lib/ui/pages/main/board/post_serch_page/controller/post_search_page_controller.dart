import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PostSearchPageController extends GetxController{

  final TextEditingController searchController = TextEditingController();
  final RxString search = ''.obs;
  String get searchText => search.value;
  set searchText(String value) => search.value = value;

  @override
  void onInit() {
    super.onInit();
    searchController.addListener(() {
      searchText = searchController.text;
    });
  }
}
