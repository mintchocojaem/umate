import 'dart:io';
import 'package:danvery/core/theme/app_text_theme.dart';
import 'package:danvery/core/theme/palette.dart';
import 'package:danvery/domain/board/general_board/model/file_model.dart';
import 'package:danvery/domain/board/post/petition_post/model/petition_post_write_model.dart';
import 'package:danvery/ui/pages/main/board/petition_post_write_page/controller/petition_post_write_page_controller.dart';
import 'package:danvery/ui/widgets/app_bar/transparent_app_bar.dart';
import 'package:danvery/ui/widgets/board/category_button_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class PetitionPostWritePage extends GetView<PetitionPostWritePageController> {
  const PetitionPostWritePage({super.key});

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
            child: Obx(
                  () =>
                  TextButton(
                    style: TextButton.styleFrom(
                      backgroundColor: Palette.blue,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5),
                      ),
                      disabledBackgroundColor: Palette.lightGrey,
                    ),
                    onPressed: !controller.isPosting.value
                        ? () async {
                      PetitionPostWriteModel petitionPostWriteModel = PetitionPostWriteModel(
                        title: controller.titleController.text,
                        body: controller.contentController.text,
                        files: controller.imageList
                            .map((e) => FileModel.fromImagePicker(e))
                            .toList(),
                        tagIds: [PetitionPostTag.values[controller.selectedTag.value].id],
                      );
                      await controller.writePetitionPost(petitionPostWriteModel);
                    } : null, child: Text(
                      '등록',
                      style: lightStyle.copyWith(
                          color: Palette.pureWhite,
                          fontWeight: FontWeight.bold),
                    ),
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
              CategoryButtonBar(
                selectedIndex: controller.selectedTag.value,
                categories:
                PetitionPostTag.values.map((e) => e.nameKR).toList(),
                selectedBackGroundColor: Palette.blue,
                unSelectedBackGroundColor: Palette.white,
                selectedTextColor: Palette.pureWhite,
                unSelectedTextColor: Palette.grey,
                onTap: (value) async {
                  controller.selectedTag.value = value;
                },
              ),
              const SizedBox(
                height: 8,
              ),
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
                    () =>
                    Column(
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
                                color: Palette.grey,
                                fontWeight: FontWeight.bold),
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
                              for (int i = 0; i < controller.imageList
                                  .length; i++)
                                Padding(
                                  padding: const EdgeInsets.only(left: 16),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      image: DecorationImage(
                                        fit: BoxFit.cover,
                                        image: Image
                                            .file(
                                          File(controller.imageList[i].path),
                                        )
                                            .image,
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
                                        color: Palette.darkWhite.withOpacity(
                                            0.6),
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
      builder: (BuildContext context) =>
          CupertinoActionSheet(
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
                  if (await controller.permissionService
                      .getCameraPermission()) {
                    final XFile? image = await picker.pickImage(
                      source: ImageSource.camera,
                      imageQuality: 80,
                      maxHeight: 1920,
                      maxWidth: 1080,
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
                  if (await controller.permissionService
                      .getGalleryPermission()) {
                    await picker
                        .pickMultiImage(
                      imageQuality: 80,
                      maxHeight: 1920,
                      maxWidth: 1080,
                    ).then((value) {
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
