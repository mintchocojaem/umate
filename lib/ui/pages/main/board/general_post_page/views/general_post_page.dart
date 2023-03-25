import 'package:danvery/utils/theme/app_text_theme.dart';
import 'package:danvery/utils/theme/palette.dart';
import 'package:danvery/ui/widgets/app_bar/transparent_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

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
          Get.back();
        },
        actions: [],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        child: Obx(() => controller.isLoadedGeneralPost &&
                controller.isLoadedGeneralComment
            ? SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        CircleAvatar(
                          radius: 20,
                          backgroundImage:
                              Image.asset("assets/icons/user/profile_icon.png")
                                  .image,
                          backgroundColor: Colors.transparent,
                        ),
                        const SizedBox(
                          width: 8,
                        ),
                        Text(
                          controller.generalPostModel.author,
                          style: regularStyle.copyWith(
                              color: Palette.darkGrey,
                              fontWeight: FontWeight.w500),
                        ),
                        const SizedBox(
                          width: 8,
                        ),
                        Text(
                          controller.generalPostModel.createdAt,
                          style: tinyStyle.copyWith(color: Palette.grey),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          controller.generalPostModel.title,
                          style: regularStyle.copyWith(
                              fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        Text(
                          controller.generalPostModel.body,
                          style: regularStyle,
                        )
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
                            borderRadius:
                                const BorderRadius.all(Radius.circular(10)),
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
                            borderRadius:
                                const BorderRadius.all(Radius.circular(10)),
                          ),
                          width: 128,
                          height: 128,
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Wrap(
                          spacing: 12,
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
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
                                  controller.generalPostModel.likes.toString(),
                                  style:
                                      lightStyle.copyWith(color: Palette.grey),
                                )
                              ],
                            ),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Image.asset(
                                  "assets/icons/post/comment_unselected.png",
                                  width: 12,
                                  height: 12,
                                  color: Palette.grey,
                                ),
                                const SizedBox(
                                  width: 4,
                                ),
                                Text(
                                  controller.generalCommentListModel
                                      .generalCommentList.length
                                      .toString(),
                                  style:
                                      lightStyle.copyWith(color: Palette.grey),
                                )
                              ],
                            ),
                          ],
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    Divider(
                      color: Palette.grey,
                      height: 0,
                    ),
                    ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: controller
                          .generalCommentListModel.generalCommentList.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(
                              height: 16,
                            ),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
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
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      controller.generalCommentListModel
                                          .generalCommentList[index].author,
                                      style: regularStyle.copyWith(
                                          color: Palette.darkGrey,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text(
                                      controller.generalCommentListModel
                                          .generalCommentList[index].createdAt,
                                      style: tinyStyle.copyWith(
                                          color: Palette.grey),
                                    ),
                                    const SizedBox(
                                      height: 8,
                                    ),
                                    Text(
                                      controller.generalCommentListModel
                                          .generalCommentList[index].text,
                                      style: regularStyle,
                                    ),
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
                                  ],
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 16,
                            ),
                            Divider(
                              color: Palette.grey,
                              height: 0,
                            ),
                          ],
                        );
                      },
                    )
                  ],
                ),
              )
            : const SizedBox(
                height: 200,
                child: Center(child: CircularProgressIndicator()),
              )),
      ),
    );
  }
}
