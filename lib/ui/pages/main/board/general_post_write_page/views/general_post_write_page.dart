import 'package:danvery/domain/board/post/general_post/model/general_post_model.dart';
import 'package:danvery/ui/pages/main/board/general_post_page/controller/general_post_page_controller.dart';
import 'package:danvery/ui/pages/main/board/general_post_write_page/controller/general_post_write_page_controller.dart';
import 'package:danvery/ui/widgets/app_bar/transparent_app_bar.dart';
import 'package:danvery/utils/theme/palette.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../widgets/modern/modern_form_button.dart';

class GeneralPostWritePage extends GetView<GeneralPostWritePageController> {
  const GeneralPostWritePage({super.key});

  @override
  Widget build(BuildContext context) {
    //토큰 받아올때 이렇게 직접적으로 받아오지말고 null 주고 logincontroller is loaded 됐을때 받아와야함

    return Scaffold(
        appBar: TransparentAppBar(
          isDarkMode: Get.isDarkMode,
          title: '게시글 작성',
          automaticallyImplyLeading: true,
          onPressedLeading: () => Get.back(),
        ),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        TextField(
                          controller: controller.titleController,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: "제목"
                          ),
                          maxLines: 1,
                        ),
                        Divider(
                          color: Palette.lightGrey,
                          thickness: 1,
                        ),
                        TextField(
                          controller: controller.contentController,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: "내용"
                          ),
                          maxLines: 20,
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 16),
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: ModernFormButton(
                      text: "글 올리기",
                      onPressed: () {
                        GeneralPostModel postModel = GeneralPostModel();
                        controller
                            .writeGeneralPost(
                                controller.loginService.loginModel.accessToken,
                                postModel)
                            .then((value) {
                          if (value) {
                            Get.back();
                          } else {
                            Get.snackbar("Error", "게시글 업로드에 실패했습니다.");
                          }
                        });
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
