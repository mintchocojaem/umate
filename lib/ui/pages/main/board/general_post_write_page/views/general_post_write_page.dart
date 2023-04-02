import 'dart:io';

import 'package:danvery/core/theme/app_text_theme.dart';
import 'package:danvery/core/theme/palette.dart';
import 'package:danvery/domain/board/post/general_post/model/general_post_model.dart';
import 'package:danvery/ui/pages/main/board/general_post_write_page/controller/general_post_write_page_controller.dart';
import 'package:danvery/ui/widgets/app_bar/transparent_app_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

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
        actions: [
          Padding(
            padding: const EdgeInsets.only(top: 12, bottom: 12, right: 12),
            child: TextButton(
              style: TextButton.styleFrom(
                backgroundColor: Palette.blue,
              ),
              onPressed: () async {
                GeneralPostModel postModel = GeneralPostModel();

                if (await controller.writeGeneralPost(
                    controller.loginService.loginModel.accessToken,
                    postModel)) {
                  Get.back();
                }
              },
              child: Text(
                '등록',
                style: lightStyle.copyWith(
                    color: Palette.pureWhite, fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
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
                              fontWeight: FontWeight.bold, color: Palette.grey),
                        ),
                      ),
                      Divider(
                        color: Palette.lightGrey,
                        thickness: 1,
                      ),
                      TextField(
                        controller: controller.contentController,
                        style: regularStyle.copyWith(color: Palette.darkGrey),
                        maxLength: 500,
                        maxLines: 10,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          counterText: "",
                          hintText: "내용",
                          hintStyle: regularStyle.copyWith(
                              color: Palette.grey, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Obx(
                () => Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Divider(
                      color: Palette.lightGrey,
                      thickness: 1,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 4),
                      child: Text(
                        "사진 첨부하기",
                        style: regularStyle.copyWith(
                            color: Palette.grey, fontWeight: FontWeight.bold),
                      ),
                    ),
                    const SizedBox(height: 4,),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: [
                          GestureDetector(
                            onTap: () {
                              getImageBottomSheet();
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                color: Palette.lightGrey,
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(10)),
                              ),
                              height: 80,
                              width: 80,
                              child: Icon(
                                Icons.image_outlined,
                                color: Palette.grey,
                              ),
                            ),
                          ),
                          for (int i = 0; i < controller.imageList.length; i++)
                            Padding(
                              padding: const EdgeInsets.only(left: 16),
                              child: Container(
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                    fit: BoxFit.cover,
                                    image: Image.file(
                                      File(controller.imageList[i].path),
                                    ).image,
                                  ),
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(10)),
                                ),
                                height: 80,
                                width: 80,
                                child: Align(
                                  alignment: Alignment.bottomCenter,
                                  child: Container(
                                    width: double.infinity,
                                    height: 30,
                                    color: Palette.darkWhite.withOpacity(0.6),
                                    child: IconButton(
                                      icon: Icon(
                                        Icons.delete,
                                        color: Palette.darkGrey,
                                        size: 20,
                                      ),
                                      onPressed: () {
                                        controller.imageList.removeAt(i);
                                      },
                                    ),
                                  ),
                                ),
                              ),
                            ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> getImageBottomSheet() async {
    final ImagePicker picker = ImagePicker();

    showCupertinoModalPopup(
      context: Get.context!,
      builder: (BuildContext context) => CupertinoActionSheet(
        cancelButton: CupertinoActionSheetAction(
          child: const Text('취소'),
          onPressed: () {
            Get.back();
          },
        ),
        actions: <Widget>[
          CupertinoActionSheetAction(
            child: const Text('사진 찍기'),
            onPressed: () async {
              Get.back();
              if (await controller.permissionService.getCameraPermission()) {
                final XFile? image = await picker.pickImage(
                    source: ImageSource.camera, imageQuality: 80);
                if (image != null) {
                  controller.imageList.add(image);
                }
              }
            },
          ),
          CupertinoActionSheetAction(
            child: const Text('사진 보관함',),
            onPressed: () async {
              Get.back();
              if (await controller.permissionService.getGalleryPermission()) {
                controller.imageList.addAll(await picker.pickMultiImage());
              }
            },
          )
        ],
      ),
    );

    //await picker.pickImage(source: ImageSource.camera);
    /*
    // Pick a video.
        final XFile? galleryVideo =
        await picker.pickVideo(source: ImageSource.gallery);
    // Capture a video.
        final XFile? cameraVideo = await picker.pickVideo(source: ImageSource.camera);
    // Pick multiple images.
        final List<XFile> images = await picker.pickMultiImage();

         */
  }
}
