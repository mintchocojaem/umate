import 'dart:io';
import 'package:danvery/core/theme/app_text_theme.dart';
import 'package:danvery/core/theme/palette.dart';
import 'package:danvery/domain/board/general_board/model/file_model.dart';
import 'package:danvery/domain/board/post/general_post/model/general_post_wirte_model.dart';
import 'package:danvery/ui/pages/main/board/general_post_write_page/controller/general_post_write_page_controller.dart';
import 'package:danvery/ui/widgets/app_bar/transparent_app_bar.dart';
import 'package:danvery/ui/widgets/modern/modern_form_button.dart';
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
        onPressedLeading: () {
          (controller.titleController.value.text.isNotEmpty ||
                  controller.contentController.value.text.isNotEmpty)
              ? showCupertinoDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return CupertinoAlertDialog(
                      title: const Text("게시글 작성 취소"),
                      content: const Text("작성 중인 게시글이 있습니다. \n작성을 취소하시겠습니까?"),
                      actions: [
                        CupertinoDialogAction(
                          child: const Text(
                            '취소',
                          ),
                          onPressed: () {
                            Get.back();
                          },
                        ),
                        CupertinoDialogAction(
                          child: Text(
                            '확인',
                            style: TextStyle(
                              color: Palette.lightRed,
                            ),
                          ),
                          onPressed: () async {
                            Get.back();
                            Get.back();
                          },
                        ),
                      ],
                    );
                  },
                )
              : Get.back();
        },
        actions: [
          Padding(
            padding: const EdgeInsets.only(top: 12, bottom: 12, right: 12),
            child: Obx(
              () => ModernFormButton(
                isEnabled: !controller.isPosting.value &&
                    controller.titleController.value.text.isNotEmpty &&
                    controller.contentController.value.text.isNotEmpty,
                width: 60,
                coolDownTime: 3,
                text: "완료",
                onPressed: () async {
                  GeneralPostWriteModel generalPostWriteModel =
                      GeneralPostWriteModel(
                    title: controller.titleController.value.text,
                    body: controller.contentController.value.text,
                    files: controller.imageList
                        .map((e) => FileModel.fromImagePicker(e))
                        .toList(),
                  );

                  await controller.writeGeneralPost(generalPostWriteModel);
                },
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
                        controller: controller.titleController.value,
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
                        controller: controller.contentController.value,
                        style: regularStyle.copyWith(color: Palette.darkGrey),
                        maxLength: 5000,
                        maxLines: null,
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
                    const SizedBox(
                      height: 4,
                    ),
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
                                      splashColor: Colors.transparent,
                                      highlightColor: Colors.transparent,
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
                  source: ImageSource.camera,
                  imageQuality: 50,
                );
                if (image != null) {
                  controller.imageList.add(image);
                }
              }
            },
          ),
          CupertinoActionSheetAction(
            child: const Text(
              '사진 보관함',
            ),
            onPressed: () async {
              Get.back();
              if (await controller.permissionService.getGalleryPermission()) {
                await picker
                    .pickMultiImage(
                  imageQuality: 50,
                )
                    .then((value) {
                  controller.imageList.addAll(value);
                });
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
