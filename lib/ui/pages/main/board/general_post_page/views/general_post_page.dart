import 'package:danvery/core/theme/app_text_theme.dart';
import 'package:danvery/core/theme/palette.dart';
import 'package:danvery/ui/widgets/app_bar/transparent_app_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:get/get.dart';
import 'package:html2md/html2md.dart' as html2md;
import 'package:url_launcher/url_launcher_string.dart';

import '../controller/general_post_page_controller.dart';

class GeneralPostPage extends GetView<GeneralPostPageController> {
  const GeneralPostPage({super.key});

  @override
  Widget build(BuildContext context) {
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
                controller.isLoadedGeneralComment.value
            ? Column(
                children: [
                  Expanded(
                    child: Padding(
                      padding:
                          const EdgeInsets.only(top: 16, left: 16, right: 16),
                      child: RefreshIndicator(
                        onRefresh: () async {
                          await controller.getGeneralPost(
                              controller.generalPostModel.value.id);
                          await controller.getFirstGeneralComment(
                              controller.generalPostModel.value.id);
                        },
                        child: SingleChildScrollView(
                          controller: controller.generalPostScrollController,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                key: controller.generalPostHeightKey,
                                children: [
                                  Stack(
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
                                                controller.generalPostModel
                                                    .value.author,
                                                style: regularStyle.copyWith(
                                                    color: Palette.darkGrey,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              Text(
                                                controller.generalPostModel
                                                    .value.createdAt,
                                                style: tinyStyle.copyWith(
                                                    color: Palette.grey),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                      Positioned.fill(
                                        child: Align(
                                          alignment: Alignment.topRight,
                                          child: IconButton(
                                            onPressed: () {},
                                            icon: Icon(
                                              Icons.more_vert,
                                              color: Palette.darkGrey,
                                              size: 20,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 16,
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        controller.generalPostModel.value.title,
                                        style: titleStyle.copyWith(
                                            color: Palette.darkGrey),
                                      ),
                                      const SizedBox(
                                        height: 8,
                                      ),
                                      MarkdownBody(
                                        softLineBreak: true,
                                        shrinkWrap: true,
                                        onTapLink: (text, href, title) {
                                          launchUrlString(href!);
                                        },
                                        styleSheetTheme:
                                            MarkdownStyleSheetBaseTheme
                                                .cupertino,
                                        styleSheet: MarkdownStyleSheet(
                                          //text
                                          em: regularStyle.copyWith(
                                              color: Palette.darkGrey,
                                              fontStyle: FontStyle.normal),
                                          del: regularStyle.copyWith(
                                              color: Palette.darkGrey,
                                              fontStyle: FontStyle.normal),
                                          strong: regularStyle.copyWith(
                                              color: Palette.darkGrey,
                                              fontWeight: FontWeight.normal),
                                          //heading
                                          h1: regularStyle.copyWith(
                                              color: Palette.darkGrey),
                                          //sub
                                          h2: regularStyle.copyWith(
                                              color: Palette.darkGrey),
                                          h3: regularStyle.copyWith(
                                              color: Palette.darkGrey),
                                          h4: regularStyle.copyWith(
                                              color: Palette.darkGrey),
                                          h5: regularStyle.copyWith(
                                              color: Palette.darkGrey),
                                          h6: regularStyle.copyWith(
                                              color: Palette.darkGrey),
                                          //body
                                          p: regularStyle.copyWith(
                                              color: Palette.darkGrey,
                                              fontWeight: FontWeight.normal),
                                          //link
                                          a: regularStyle.copyWith(
                                              color: Palette.lightBlue,
                                              decoration:
                                                  TextDecoration.underline),
                                          //code
                                          code: regularStyle.copyWith(
                                              color: Palette.darkGrey,
                                              backgroundColor:
                                                  Palette.lightGrey),
                                          //codeblock
                                          codeblockDecoration: BoxDecoration(
                                            color: Palette.lightGrey,
                                          ),
                                          //blockquote
                                          blockquoteDecoration: BoxDecoration(
                                            color: Palette.lightGrey,
                                          ),
                                          //table
                                          tableHead: regularStyle.copyWith(
                                              color: Palette.darkGrey,
                                              fontWeight: FontWeight.bold),
                                          tableBody: regularStyle.copyWith(
                                              color: Palette.darkGrey,
                                              fontWeight: FontWeight.normal),
                                          tableBorder: TableBorder.all(
                                            color: Palette.lightGrey,
                                            width: 1,
                                          ),
                                          //list
                                          listBullet: regularStyle.copyWith(
                                              color: Palette.darkGrey,
                                              fontWeight: FontWeight.normal),
                                          listBulletPadding:
                                              const EdgeInsets.only(left: 8),
                                          listIndent: 8,
                                        ),
                                        data: html2md.convert(controller
                                            .generalPostModel.value.body),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 16,
                                  ),
                                  Row(
                                    children: [
                                      Container(
                                        decoration: BoxDecoration(
                                          color: Palette.white,
                                          borderRadius: const BorderRadius.all(
                                              Radius.circular(10)),
                                        ),
                                        width: 128,
                                        height: 128,
                                      ),
                                      const SizedBox(
                                        width: 8,
                                      ),
                                      Container(
                                        decoration: BoxDecoration(
                                          color: Palette.white,
                                          borderRadius: const BorderRadius.all(
                                              Radius.circular(10)),
                                        ),
                                        width: 128,
                                        height: 128,
                                      ),
                                    ],
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
                                  Obx(
                                    () => OutlinedButton(
                                      style: OutlinedButton.styleFrom(
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                        side: BorderSide(
                                          width: 2,
                                          color: controller
                                                  .generalPostModel.value.liked
                                              ? Palette.lightBlue
                                              : Palette.lightGrey,
                                        ),
                                      ),
                                      child: Row(
                                        children: [
                                          Image.asset(
                                            controller.generalPostModel.value
                                                    .liked
                                                ? "assets/icons/post/like_selected.png"
                                                : "assets/icons/post/like_unselected.png",
                                            width: 18,
                                            height: 18,
                                          ),
                                          const SizedBox(
                                            width: 8,
                                          ),
                                          Text(
                                            "좋아요",
                                            style: lightStyle.copyWith(
                                              fontWeight: FontWeight.w500,
                                              color: controller.generalPostModel
                                                      .value.liked
                                                  ? Palette.lightBlue
                                                  : Palette.grey,
                                            ),
                                          ),
                                          const SizedBox(
                                            width: 8,
                                          ),
                                          Text(
                                            controller
                                                .generalPostModel.value.likes
                                                .toString(),
                                            style: lightStyle.copyWith(
                                              fontWeight: FontWeight.w500,
                                              color: controller.generalPostModel
                                                      .value.liked
                                                  ? Palette.lightBlue
                                                  : Palette.grey,
                                            ),
                                          )
                                        ],
                                      ),
                                      onPressed: () async {
                                        controller.likeGeneralPost(controller
                                            .generalPostModel.value.id);
                                      },
                                    ),
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
                                itemCount:
                                    controller.generalComments.length + 1,
                                itemBuilder: (BuildContext context, int index) {
                                  if (index ==
                                      controller.generalComments.length) {
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
                                  return Stack(
                                    children: [
                                      Column(
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
                                                backgroundColor:
                                                    Colors.transparent,
                                              ),
                                              const SizedBox(
                                                width: 16,
                                              ),
                                              Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Text(
                                                    controller
                                                        .generalComments[index]
                                                        .author,
                                                    style:
                                                        regularStyle.copyWith(
                                                            color: Palette
                                                                .darkGrey,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                  ),
                                                  Text(
                                                    controller
                                                        .generalComments[index]
                                                        .createdAt,
                                                    style: tinyStyle.copyWith(
                                                        color: Palette.grey),
                                                  ),
                                                  const SizedBox(
                                                    height: 8,
                                                  ),
                                                  Text(
                                                    controller
                                                        .generalComments[index]
                                                        .text,
                                                    style: regularStyle,
                                                  ),
                                                  /*
                                                const SizedBox(
                                                  height: 8,
                                                ),
                                                Row(
                                                  children: [
                                                    Image.asset(
                                                      "assets/icons/post/like_unselected.png",
                                                      width: 12,
                                                      height: 12,
                                                      color: Palette.grey,
                                                    ),
                                                    const SizedBox(
                                                      width: 4,
                                                    ),

                                                    Text(
                                                      "0",
                                                      style: lightStyle.copyWith(
                                                          color: Palette.grey),
                                                    )
                                                  ],
                                                ),

                                                 */
                                                ],
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
                                      ),
                                      Positioned.fill(
                                        child: Align(
                                          alignment: Alignment.topRight,
                                          child: IconButton(
                                            onPressed: () {
                                              generalCommentPopup(controller
                                                  .generalComments[index].id);
                                            },
                                            icon: Icon(
                                              Icons.more_vert,
                                              color: Palette.grey,
                                              size: 20,
                                            ),
                                          ),
                                        ),
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
                                          const EdgeInsets.symmetric(
                                              vertical: 8, horizontal: 16),
                                      counterText: "",
                                      hintText: "댓글을 입력해주세요",
                                      hintStyle: lightStyle.copyWith(
                                        color: Palette.grey,
                                      ),
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10),
                                        borderSide: BorderSide(
                                          color: Palette.lightGrey,
                                          width: 1,
                                        ),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10),
                                        borderSide: BorderSide(
                                          color: Palette.lightGrey,
                                          width: 1,
                                        ),
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10),
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
                                        onPressed: () async{
                                          await controller
                                              .writeGeneralComment(controller
                                                  .generalPostModel.value.id);
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
              )
            : const SizedBox(
                height: 200,
                child: Center(child: CircularProgressIndicator()),
              ),
      ),
    );
  }

  void generalCommentPopup(int commentId) {
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
              CupertinoActionSheetAction(
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
                          child: const Text('확인'),
                          onPressed: () async{
                            await controller.deleteGeneralComment(
                                controller.generalPostModel.value.id,
                                commentId);
                            Get.back();
                          },
                        ),
                      ],
                    ),
                  ).then((value) => Get.back());
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
        });
  }
}
