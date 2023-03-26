import 'package:danvery/domain/board/post/general_post/model/general_post_model.dart';
import 'package:danvery/domain/board/post/general_post/repository/general_post_repository.dart';
import 'package:danvery/service/login/login_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class GeneralPostWritePageController extends GetxController{

  final GeneralPostRepository generalPostRepository = GeneralPostRepository();
  final LoginService loginService = Get.find<LoginService>();

  final TextEditingController titleController = TextEditingController();
  final RxString title = ''.obs;
  String get titleText => title.value;
  set titleText(String value) => title.value = value;

  final TextEditingController contentController = TextEditingController();
  final RxString content = ''.obs;
  String get contentText => content.value;
  set contentText(String value) => content.value = value;

  @override
  void onInit() {
    super.onInit();
    titleController.addListener(() {
      titleText = titleController.text;
    });
    contentController.addListener(() {
      contentText = contentController.text;
    });
  }

  Future<bool> writeGeneralPost(String token, GeneralPostModel generalPostModel) {
   return generalPostRepository.writeGeneralPost(token, generalPostModel);
  }

}
