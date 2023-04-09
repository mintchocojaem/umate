import 'dart:io';

import 'package:danvery/core/theme/palette.dart';
import 'package:danvery/domain/board/post/petition_post/model/petition_post_model.dart';
import 'package:danvery/routes/app_routes.dart';
import 'package:danvery/ui/pages/main/board/petition_post_page/controller/petition_post_page_controller.dart';
import 'package:danvery/ui/widgets/modern/modern_progress_indicator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher_string.dart';

import '../../../../../../core/theme/app_text_theme.dart';
import '../../../../../widgets/app_bar/transparent_app_bar.dart';
import '../../../../../widgets/modern/modern_form_button.dart';

class PetitionPostPage extends GetView<PetitionPostPageController> {
  const PetitionPostPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TransparentAppBar(
        isDarkMode: Get.isDarkMode,
        title: "청원게시판",
        automaticallyImplyLeading: true,
        onPressedLeading: () {
          controller.saveAndGetBack();
        },
        actions: [],
      ),
      body: SafeArea(
        child: Obx(
          () => controller.isLoadedPetitionPost.value
              ? Column(
                  children: [
                    Expanded(
                      child: SingleChildScrollView(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 16, horizontal: 16),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                width: double.infinity,
                                child: Stack(
                                  children: [
                                    Text(
                                      controller.petitionPost.value.title,
                                      style: titleStyle,
                                    ),
                                    Positioned.fill(
                                      child: Align(
                                        alignment: Alignment.topRight,
                                        child: IconButton(
                                          icon: Icon(
                                            Icons.more_vert,
                                            color: Palette.darkGrey,
                                            size: 20,
                                          ),
                                          onPressed: () {
                                            petitionPostPopup(
                                                controller.petitionPost.value);
                                          },
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              const SizedBox(
                                height: 16,
                              ),
                              Row(
                                children: [
                                  SizedBox(
                                    width: 72,
                                    child: Text(
                                      "청원분야",
                                      style: regularStyle.copyWith(
                                          color: Palette.grey),
                                    ),
                                  ),
                                  Text(
                                    controller
                                        .petitionPost.value.tag.first.name,
                                    style: regularStyle.copyWith(
                                        color: Palette.black),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 8,
                              ),
                              Row(
                                children: [
                                  SizedBox(
                                    width: 72,
                                    child: Text(
                                      "청원인",
                                      style: regularStyle.copyWith(
                                          color: Palette.grey),
                                    ),
                                  ),
                                  Text(
                                    controller.petitionPost.value.author,
                                    style: regularStyle.copyWith(
                                        color: Palette.black),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 8,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Flexible(
                                    flex: 10,
                                    child: Row(
                                      children: [
                                        SizedBox(
                                          width: 72,
                                          child: Text(
                                            "청원기간",
                                            style: regularStyle.copyWith(
                                                color: Palette.grey),
                                          ),
                                        ),
                                        Text(
                                          "${controller.petitionPost.value.createdAt.substring(0, 10)}"
                                          " ~ ${controller.petitionPost.value.expiresAt}",
                                          style: regularStyle.copyWith(
                                              color: Palette.black),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 8,
                              ),
                              Row(
                                children: [
                                  SizedBox(
                                    width: 72,
                                    child: Text(
                                      "청원상태",
                                      style: regularStyle.copyWith(
                                          color: Palette.grey),
                                    ),
                                  ),
                                  Text(
                                    '${controller.petitionPost.value.status} '
                                    '(${(controller.petitionPost.value.agreeCount / 50 * 100).round()}%)',
                                    style: regularStyle.copyWith(
                                        fontWeight: FontWeight.bold,
                                        color: controller.petitionPost.value
                                                    .status ==
                                                PetitionPostStatus
                                                    .expired.nameKR
                                            ? Palette.darkGrey
                                            : Palette.blue),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 8,
                              ),
                              Row(
                                children: [
                                  const SizedBox(
                                    width: 72,
                                  ),
                                  Expanded(
                                    child: ModernProgressIndicator(
                                        maxValue: 50,
                                        currentValue: controller
                                            .petitionPost.value.agreeCount
                                            .toDouble(),
                                        height: 10,
                                        color: controller.petitionPost.value
                                                    .status ==
                                                PetitionPostStatus
                                                    .expired.nameKR
                                            ? Palette.grey
                                            : Palette.blue),
                                  )
                                ],
                              ),
                              const SizedBox(
                                height: 16,
                              ),
                              Divider(
                                color: Palette.lightGrey,
                                thickness: 1,
                              ),
                              const SizedBox(
                                height: 16,
                              ),
                              Html(
                                style: {
                                  "body": Style(
                                    fontSize: FontSize(regularStyle.fontSize!),
                                    color: Palette.darkGrey,
                                    padding: EdgeInsets.zero,
                                    margin: Margins.zero,
                                  ),
                                },
                                data: controller.petitionPost.value.body,
                                onLinkTap: (String? url, RenderContext context,
                                    Map<String, String> attributes, _) {
                                  if (url != null) {
                                    launchUrlString(url);
                                  }
                                },
                              ),
                              const SizedBox(
                                height: 16,
                              ),
                              SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child: Row(
                                  children: [
                                    for (var i = 0;
                                        i <
                                            controller.petitionPost.value.files
                                                .length;
                                        i++)
                                      Padding(
                                        padding: const EdgeInsets.only(
                                          right: 8,
                                        ),
                                        child: GestureDetector(
                                          onTap: () {
                                            Get.toNamed(Routes.imageShow,
                                                arguments: {
                                                  "imagePathList": controller
                                                      .petitionPost.value.files
                                                      .map((e) => e.url),
                                                  "index": i,
                                                });
                                          },
                                          child: Container(
                                            decoration: BoxDecoration(
                                              color: Palette.lightGrey,
                                              borderRadius:
                                                  const BorderRadius.all(
                                                      Radius.circular(10)),
                                            ),
                                            width: 120,
                                            height: 120,
                                            child: ClipRRect(
                                              borderRadius:
                                                  const BorderRadius.all(
                                                      Radius.circular(10)),
                                              child: Image.file(
                                                File(controller.petitionPost
                                                    .value.files[i].url),
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                  ],
                                ),
                              ),
                              const SizedBox(
                                height: 16,
                              ),
                              SizedBox(
                                width: 180,
                                child: InkWell(
                                  onTap: () {
                                    Get.toNamed(Routes.petitionAgreeStatus);
                                  },
                                  child: Padding(
                                    padding:
                                        const EdgeInsets.symmetric(vertical: 8),
                                    child: Row(
                                      children: [
                                        Icon(Icons.people, color: Palette.blue),
                                        const SizedBox(
                                          width: 8,
                                        ),
                                        Text(
                                          "참여인원",
                                          style: regularStyle.copyWith(
                                              fontWeight: FontWeight.bold,
                                              color: Palette.darkGrey),
                                        ),
                                        const SizedBox(
                                          width: 8,
                                        ),
                                        Text(
                                          "${controller.petitionPost.value.agreeCount}명",
                                          style: regularStyle.copyWith(
                                              fontWeight: FontWeight.bold,
                                              color: Palette.blue),
                                        ),
                                        const SizedBox(width: 4),
                                        Icon(Icons.arrow_forward_ios_rounded,
                                            color: Palette.darkGrey,
                                            size: regularStyle.fontSize),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              Divider(
                                color: Palette.lightGrey,
                                thickness: 1,
                              ),
                              const SizedBox(
                                height: 8,
                              ),
                              controller.petitionPost.value.answer != null
                                  ? Container(
                                      width: double.infinity,
                                      decoration: BoxDecoration(
                                        color: Palette.lightGrey,
                                        borderRadius: const BorderRadius.all(
                                            Radius.circular(10)),
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.all(16),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              "답변",
                                              style: regularStyle.copyWith(
                                                  fontWeight: FontWeight.bold,
                                                  color: Palette.darkGrey),
                                            ),
                                            const SizedBox(
                                              height: 8,
                                            ),
                                            Text(
                                              controller
                                                  .petitionPost.value.answer!,
                                              style: regularStyle.copyWith(
                                                  color: Palette.darkGrey),
                                            ),
                                          ],
                                        ),
                                      ),
                                    )
                                  : const SizedBox(),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 16),
                      child: ModernFormButton(
                        isEnabled: (!controller.petitionPost.value.agreed) &&
                            (controller.petitionPost.value.status !=
                                PetitionPostStatus.expired.nameKR),
                        onPressed: () async {
                          controller.agreePetition();
                        },
                        text: (controller.petitionPost.value.status ==
                                PetitionPostStatus.expired.nameKR)
                            ? '만료된 청원입니다'
                            : '동의하기',
                      ),
                    ),
                  ],
                )
              : const SizedBox(
                  height: 400,
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                ),
        ),
      ),
    );
  }

  void petitionPostPopup(PetitionPostModel petitionPostModel) {
    showCupertinoModalPopup(
        context: Get.context!,
        builder: (BuildContext context) {
          return CupertinoActionSheet(
            actions: <Widget>[
              CupertinoActionSheetAction(
                child: Text(
                  '신고하기',
                  style: TextStyle(
                    color: Palette.lightRed,
                  ),
                ),
                onPressed: () {
                  Get.back();
                },
              ),
              petitionPostModel.mine
                  ? CupertinoActionSheetAction(
                      child: const Text(
                        '삭제하기',
                      ),
                      onPressed: () {
                        Get.dialog(
                          CupertinoAlertDialog(
                            title: const Text('게시글 삭제'),
                            content: const Text('게시글을 삭제하시겠습니까?'),
                            actions: <Widget>[
                              CupertinoDialogAction(
                                child: const Text('취소'),
                                onPressed: () {
                                  Get.back();
                                },
                              ),
                              CupertinoDialogAction(
                                child: const Text('확인'),
                                onPressed: () async {
                                  Get.back();
                                  await controller
                                      .deletePetitionPost(petitionPostModel.id);
                                },
                              ),
                            ],
                          ),
                        ).then((value) => Get.back());
                      },
                    )
                  : const SizedBox(),
            ],
            cancelButton: CupertinoActionSheetAction(
              onPressed: () {
                Get.back();
              },
              child: const Text('취소'),
            ),
          );
        });
  }
}
