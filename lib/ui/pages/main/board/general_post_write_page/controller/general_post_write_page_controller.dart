import 'package:danvery/domain/board/post/general_post/model/general_post_model.dart';
import 'package:danvery/domain/board/post/general_post/repository/general_post_repository.dart';
import 'package:danvery/service/login/login_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class GeneralPostWritePageController extends GetxController {
  final GeneralPostRepository _generalPostRepository = GeneralPostRepository();
  final LoginService loginService = Get.find<LoginService>();

  final TextEditingController titleController = TextEditingController();
  final RxString titleText = ''.obs;

  final TextEditingController contentController = TextEditingController();
  final RxString contentText = ''.obs;


  @override
  void onInit() {
    super.onInit();
    titleController.addListener(() {
      titleText.value = titleController.text;
    });
    contentController.addListener(() {
      contentText.value = contentController.text;
    });
  }

  Future<bool> writeGeneralPost(
      String token, GeneralPostModel generalPostModel) {
    return _generalPostRepository.writeGeneralPost(
        token: token, postModel: generalPostModel);
  }
}
