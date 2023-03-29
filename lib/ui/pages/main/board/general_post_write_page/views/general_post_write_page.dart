import 'package:danvery/domain/board/post/general_post/model/general_post_model.dart';
import 'package:danvery/ui/pages/main/board/general_post_write_page/controller/general_post_write_page_controller.dart';
import 'package:danvery/ui/widgets/app_bar/transparent_app_bar.dart';
import 'package:danvery/utils/theme/app_text_theme.dart';
import 'package:danvery/utils/theme/palette.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../widgets/modern/modern_form_button.dart';

class GeneralPostWritePage extends GetView<GeneralPostWritePageController> {
  const GeneralPostWritePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: TransparentAppBar(
          isDarkMode: Get.isDarkMode,
          title: '글 작성하기',
          automaticallyImplyLeading: true,
          onPressedLeading: () => Get.back(),
        ),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TextField(
                          controller: controller.titleController,
                          maxLines: 1,
                          style: regularStyle.copyWith(
                              fontWeight: FontWeight.bold,
                              color: Palette.darkGrey),
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: "제목",
                            hintStyle: regularStyle.copyWith(
                                fontWeight: FontWeight.bold,
                                color: Palette.grey),
                          ),
                        ),
                        Divider(
                          color: Palette.lightGrey,
                          thickness: 1,
                        ),
                        TextField(
                          controller: controller.contentController,
                          style: regularStyle.copyWith(color: Palette.darkGrey),
                          maxLines: 20,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: "내용",
                            hintStyle: regularStyle.copyWith(
                                color: Palette.grey,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        Divider(
                          color: Palette.lightGrey,
                          thickness: 1,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8),
                          child: Text(
                            "사진 첨부하기",
                            style: regularStyle.copyWith(
                                color: Palette.grey, fontWeight: FontWeight.bold),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            controller.getImages();
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              color: Palette.lightGrey,
                              borderRadius: const BorderRadius.all(Radius.circular(10)),
                            ),
                            height: 100,
                            width: 100,
                            child: Icon(
                              Icons.image_outlined,
                              color: Palette.grey,
                            ),
                          ),
                        )
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
