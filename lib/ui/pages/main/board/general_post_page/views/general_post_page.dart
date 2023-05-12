import 'dart:io';

import 'package:danvery/core/theme/app_text_theme.dart';
import 'package:danvery/core/theme/palette.dart';
import 'package:danvery/domain/board/post/general_post/model/general_comment_model.dart';
import 'package:danvery/domain/board/post/general_post/model/general_post_model.dart';
import 'package:danvery/routes/app_routes.dart';
import 'package:danvery/ui/pages/main/board/general_post_page/controller/general_post_page_controller.dart';
import 'package:danvery/ui/widgets/app_bar/transparent_app_bar.dart';
import 'package:danvery/ui/widgets/getx_snackbar/getx_snackbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher_string.dart';

class GeneralPostPage extends GetView<GeneralPostPageController> {
  const GeneralPostPage({super.key});

  @override
  Widget build(BuildContext context) {
    final GlobalKey generalPostHeightKey = GlobalKey();
    controller.generalPostHeightKey = generalPostHeightKey;

    return Scaffold(
      appBar: TransparentAppBar(
        isDarkMode: Get.isDarkMode,
        title: "자유게시판",
        automaticallyImplyLeading: true,
        onPressedLeading: () {
          controller.saveAndGetBack();
        },
        actions: [],
      ),
      body: Obx(
        () => controller.isLoadedGeneralPost.value &&
                controller.isLoadedGeneralComment.value &&
                controller.isLoadedImageList.value
            ? RefreshIndicator(
                onRefresh: () async {
                  await controller.getGeneralPost();
                  await controller.getGeneralCommentWithRefresh(true);
                },
                child: Column(
                  children: [
                    Expanded(
                      child: Padding(
                        padding:
                            const EdgeInsets.only(top: 16, left: 16, right: 16),
                        child: SingleChildScrollView(
                          physics: const AlwaysScrollableScrollPhysics(),
                          controller: controller.generalPostScrollController,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                key: generalPostHeightKey,
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          CircleAvatar(
                                            radius: 20,
                                            backgroundImage: Image.asset(
                                                    "assets/icons/user/profile_icon.png")
                                                .image,
                                            backgroundColor: Colors.transparent,
                                          ),
                                          const SizedBox(
                                            width: 8,
                                          ),
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                controller
                                                    .generalPost.value.author,
                                                style: regularStyle.copyWith(
                                                    color: Palette.darkGrey,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              Text(
                                                controller.generalPost.value
                                                    .createdAt,
                                                style: tinyStyle.copyWith(
                                                    color: Palette.grey),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                      IconButton(
                                        splashColor: Colors.transparent,
                                        highlightColor: Colors.transparent,
                                        onPressed: () {
                                          generalPostPopup(
                                              controller.generalPost.value);
                                        },
                                        icon: Icon(
                                          Icons.more_vert,
                                          color: Palette.darkGrey,
                                          size: 20,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        controller.generalPost.value.title,
                                        style: smallTitleStyle.copyWith(
                                            color: Palette.darkGrey),
                                      ),
                                      const SizedBox(
                                        height: 8,
                                      ),
                                      Text(
                                        controller.generalPost.value.body,
                                        style: regularStyle.copyWith(
                                            color: Palette.darkGrey),
                                      ),
                                    ],
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
                                                controller.generalPost.value
                                                    .files.length;
                                            i++)
                                          Padding(
                                            padding: const EdgeInsets.only(
                                              right: 8,
                                            ),
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
                                                child:
                                                    controller.generalPost.value
                                                            .files[i].mimeType
                                                            .contains('image')
                                                        ? InkWell(
                                                            onTap: () {
                                                              Get.toNamed(
                                                                  Routes
                                                                      .imageShow,
                                                                  arguments: {
                                                                    "imagePathList": controller
                                                                        .generalPost
                                                                        .value
                                                                        .files
                                                                        .map((e) =>
                                                                            e.url),
                                                                    "index": i,
                                                                  });
                                                            },
                                                            child: Image.file(
                                                              File(controller
                                                                  .generalPost
                                                                  .value
                                                                  .files[i]
                                                                  .url),
                                                              fit: BoxFit.cover,
                                                            ),
                                                          )
                                                        : InkWell(
                                                            onTap: () {
                                                              launchUrlString(
                                                                  controller
                                                                      .generalPost
                                                                      .value
                                                                      .files[i]
                                                                      .url);
                                                            },
                                                            child: Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .all(8.0),
                                                              child: Column(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .center,
                                                                children: [
                                                                  Text(
                                                                    controller
                                                                            .generalPost
                                                                            .value
                                                                            .files[i]
                                                                            .originalName ??
                                                                        "file",
                                                                    textAlign:
                                                                        TextAlign
                                                                            .center,
                                                                    maxLines: 2,
                                                                    style:
                                                                        const TextStyle(
                                                                      overflow:
                                                                          TextOverflow
                                                                              .ellipsis,
                                                                    ),
                                                                  ),
                                                                  const SizedBox(
                                                                    height: 8,
                                                                  ),
                                                                  const Icon(Icons
                                                                      .file_download)
                                                                ],
                                                              ),
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
                              const SizedBox(
                                height: 8,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "댓글 ${controller.generalCommentList.value.totalElements.toString()}",
                                    style: regularStyle.copyWith(
                                        fontWeight: FontWeight.bold,
                                        color: Palette.black),
                                  ),
                                  OutlinedButton(
                                    style: OutlinedButton.styleFrom(
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      side: BorderSide(
                                        width: 2,
                                        color:
                                            controller.generalPost.value.liked
                                                ? Palette.lightBlue
                                                : Palette.lightGrey,
                                      ),
                                    ),
                                    child: Row(
                                      children: [
                                        Image.asset(
                                          controller.generalPost.value.liked
                                              ? "assets/icons/post/like_selected.png"
                                              : "assets/icons/post/like_unselected.png",
                                          width: 18,
                                          height: 18,
                                        ),
                                        const SizedBox(
                                          width: 8,
                                        ),
                                        Text(
                                          "LIKE",
                                          style: lightStyle.copyWith(
                                            fontWeight: FontWeight.w500,
                                            color: controller
                                                    .generalPost.value.liked
                                                ? Palette.lightBlue
                                                : Palette.grey,
                                          ),
                                        ),
                                        const SizedBox(
                                          width: 8,
                                        ),
                                        Text(
                                          controller.generalPost.value.likes
                                              .toString(),
                                          style: lightStyle.copyWith(
                                            fontWeight: FontWeight.w500,
                                            color: controller
                                                    .generalPost.value.liked
                                                ? Palette.lightBlue
                                                : Palette.grey,
                                          ),
                                        )
                                      ],
                                    ),
                                    onPressed: () async {
                                      controller.likeGeneralPost();
                                    },
                                  ),
                                ],
                              ),
                              Divider(
                                color: Palette.lightGrey,
                                thickness: 1,
                              ),
                              ListView.builder(
                                physics: const NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                itemCount: controller.generalCommentList.value
                                        .generalComments.length +
                                    1,
                                itemBuilder: (BuildContext context, int index) {
                                  final generalCommentList =
                                      controller.generalCommentList.value;
                                  if (index ==
                                      generalCommentList
                                          .generalComments.length) {
                                    if (controller
                                        .generalCommentList.value.last) {
                                      return const SizedBox();
                                    } else {
                                      return const Padding(
                                        padding: EdgeInsets.all(16.0),
                                        child: Center(
                                            child: CircularProgressIndicator()),
                                      );
                                    }
                                  }
                                  return Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const SizedBox(
                                        height: 8,
                                      ),
                                      Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          CircleAvatar(
                                            radius: 20,
                                            backgroundImage: Image.asset(
                                                    "assets/icons/user/profile_icon.png")
                                                .image,
                                            backgroundColor: Colors.transparent,
                                          ),
                                          const SizedBox(
                                            width: 16,
                                          ),
                                          Expanded(
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Row(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Text(
                                                          generalCommentList
                                                              .generalComments[
                                                                  index]
                                                              .author,
                                                          style: regularStyle
                                                              .copyWith(
                                                                  color: Palette
                                                                      .darkGrey,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold),
                                                        ),
                                                        Text(
                                                          generalCommentList
                                                              .generalComments[
                                                                  index]
                                                              .createdAt,
                                                          style: tinyStyle
                                                              .copyWith(
                                                                  color: Palette
                                                                      .grey),
                                                        ),
                                                      ],
                                                    ),
                                                    IconButton(
                                                      splashColor:
                                                          Colors.transparent,
                                                      highlightColor:
                                                          Colors.transparent,
                                                      onPressed: () {
                                                        generalCommentPopup(
                                                            generalCommentList
                                                                    .generalComments[
                                                                index]);
                                                      },
                                                      icon: Icon(
                                                        Icons.more_vert,
                                                        color: Palette.darkGrey,
                                                        size: 20,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                Text(
                                                  generalCommentList
                                                      .generalComments[index]
                                                      .text,
                                                  style: regularStyle,
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 8,
                                      ),
                                      Divider(
                                        color: Palette.lightGrey,
                                        thickness: 1,
                                      ),
                                    ],
                                  );
                                },
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        color: Palette.transparent,
                      ),
                      child: SafeArea(
                        child: Padding(
                          padding: const EdgeInsets.all(8),
                          child: Row(
                            children: [
                              Expanded(
                                child: Stack(
                                  children: [
                                    TextField(
                                      keyboardType: TextInputType.multiline,
                                      maxLength: 1000,
                                      maxLines: 3,
                                      minLines: 1,
                                      controller:
                                          controller.commentTextController,
                                      decoration: InputDecoration(
                                        contentPadding:
                                            const EdgeInsets.only(
                                              left: 16, top: 8, bottom: 8, right: 36
                                            ),
                                        counterText: "",
                                        hintText: "댓글을 입력해주세요",
                                        hintStyle: lightStyle.copyWith(
                                          color: Palette.grey,
                                        ),
                                        border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          borderSide: BorderSide(
                                            color: Palette.lightGrey,
                                            width: 1,
                                          ),
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          borderSide: BorderSide(
                                            color: Palette.lightGrey,
                                            width: 1,
                                          ),
                                        ),
                                        enabledBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          borderSide: BorderSide(
                                            color: Palette.lightGrey,
                                            width: 1,
                                          ),
                                        ),
                                      ),
                                    ),
                                    Positioned.fill(
                                      child: Align(
                                        alignment: Alignment.bottomRight,
                                        child: IconButton(
                                          splashColor: Colors.transparent,
                                          highlightColor: Colors.transparent,
                                          onPressed: () async {
                                            await controller
                                                .writeGeneralComment();
                                          },
                                          icon: Image.asset(
                                            'assets/icons/post/send_selected.png',
                                            width: 24,
                                            height: 24,
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
                      ),
                    )
                  ],
                ),
              )
            : const SizedBox(
                height: 400,
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              ),
      ),
    );
  }

  void generalPostPopup(GeneralPostModel generalPostModel) {
    showCupertinoModalPopup(
      context: Get.context!,
      builder: (BuildContext context) {
        return CupertinoActionSheet(
          actions: <Widget>[
            controller.loginService.userInfo.value.admin
                ? CupertinoActionSheetAction(
                    child: Text(
                      '블라인드 처리하기',
                      style: TextStyle(
                        color: Palette.lightRed,
                      ),
                    ),
                    onPressed: () {
                      Get.back();
                      Get.dialog(
                        CupertinoAlertDialog(
                          title: const Text('게시글 블라인드 처리'),
                          content: const Text('게시글을 블라인드 처리하시겠습니까?'),
                          actions: <Widget>[
                            CupertinoDialogAction(
                              child: const Text('취소'),
                              onPressed: () {
                                Get.back();
                              },
                            ),
                            CupertinoDialogAction(
                              child: Text(
                                '확인',
                                style: TextStyle(color: Palette.lightRed),
                              ),
                              onPressed: () async {
                                await controller.blindGeneralPost();
                              },
                            ),
                          ],
                        ),
                      );
                    },
                  )
                : CupertinoActionSheetAction(
                    child: Text(
                      '신고하기',
                      style: TextStyle(
                        color: Palette.lightRed,
                      ),
                    ),
                    onPressed: () {
                      Get.back();
                      showCupertinoModalPopup(
                        context: context,
                        builder: (BuildContext context) {
                          return CupertinoActionSheet(
                            title: const Text("신고사유를 선택해주세요"),
                            message: const Text(
                              "누적 신고횟수가 5회 이상인 경우\n자동으로 해당 게시물이 블라인드 처리됩니다.",
                            ),
                            actions: [
                              for (int i = 0;
                                  i < ReportCategory.values.length;
                                  i++)
                                CupertinoActionSheetAction(
                                  child: Text(
                                    ReportCategory.values[i].nameKR,
                                    style: TextStyle(
                                      color: Palette.lightRed,
                                    ),
                                  ),
                                  onPressed: () async {
                                    Get.back();
                                    showCupertinoDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return CupertinoAlertDialog(
                                          title: const Text("게시글 신고하기"),
                                          content: const Text(
                                            "정말로 해당 게시물을 신고하시겠습니까?\n"
                                            "허위 신고 적발시 제재를 받을 수 있습니다"
                                          ),
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
                                                await controller
                                                    .reportGeneralPost(
                                                        ReportCategory
                                                            .values[i].name);
                                              },
                                            ),
                                          ],
                                        );
                                      },
                                    );
                                  },
                                ),
                            ],
                            cancelButton: CupertinoActionSheetAction(
                              onPressed: () {
                                Get.back();
                              },
                              child: const Text('취소'),
                            ),
                          );
                        },
                      );
                    },
                  ),
            controller.loginService.userInfo.value.admin ||
                    generalPostModel.mine
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
                              child: Text(
                                '확인',
                                style: TextStyle(color: Palette.lightRed),
                              ),
                              onPressed: () async {
                                await controller.deleteGeneralPost();
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
      },
    );
  }

  void generalCommentPopup(GeneralCommentModel generalCommentModel) {
    showCupertinoModalPopup(
      context: Get.context!,
      builder: (BuildContext context) {
        return CupertinoActionSheet(
          actions: <Widget>[
            CupertinoActionSheetAction(
              child: Text('신고하기',
                  style: TextStyle(
                    color: Palette.lightRed,
                  )),
              onPressed: () {
                Get.back();
                GetXSnackBar(
                        type: GetXSnackBarType.info,
                        title: "기능 안내사항",
                        content: "댓글 신고 기능은 조만간 업데이트로 찾아뵙겠습니다.")
                    .show();
              },
            ),
            generalCommentModel.mine
                ? CupertinoActionSheetAction(
                    child: const Text(
                      '삭제하기',
                    ),
                    onPressed: () {
                      Get.dialog(
                        CupertinoAlertDialog(
                          title: const Text('댓글 삭제'),
                          content: const Text('댓글을 삭제하시겠습니까?'),
                          actions: <Widget>[
                            CupertinoDialogAction(
                              child: const Text('취소'),
                              onPressed: () {
                                Get.back();
                              },
                            ),
                            CupertinoDialogAction(
                              child: Text(
                                '확인',
                                style: TextStyle(color: Palette.lightRed),
                              ),
                              onPressed: () async {
                                await controller.deleteGeneralComment(
                                    generalCommentModel.id);
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
      },
    );
  }
}
