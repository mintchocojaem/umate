import 'package:danvery/utils/theme/app_text_theme.dart';
import 'package:danvery/utils/theme/palette.dart';
import 'package:danvery/ui/widgets/app_bar/transparent_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/post_page_controller.dart';


class PostPage extends GetView<PostPageController> {
  const PostPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TransparentAppBar(
        isDarkMode: Get.isDarkMode,
        title: "게시글",
        automaticallyImplyLeading: true,
        onPressedLeading: () {
          Get.back();
        },
        actions: [
          IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.edit,
              )),
          const SizedBox(
            width: 16,
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        child: Obx(
          () => controller.isLoadedPost
              ? Column(
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
                          "닉네임",
                          style: regularStyle.copyWith(
                              color: Palette.darkGrey,
                              fontWeight: FontWeight.w500),
                        ),
                        const SizedBox(
                          width: 8,
                        ),
                        Text(
                          "1분 전",
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
                          controller.postModel.title,
                          style: regularStyle.copyWith(
                              fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        const Text(
                          "둘이서 같이 자고 있던데 ㅠㅠ 귀여워",
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
                                  "1",
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
                                  "1",
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
                    Column(
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
                                  "닉네임",
                                  style: regularStyle.copyWith(
                                      color: Palette.darkGrey,
                                      fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  "01/15 12:39",
                                  style:
                                      tinyStyle.copyWith(color: Palette.grey),
                                ),
                                const SizedBox(
                                  height: 8,
                                ),
                                const Text(
                                  "둘이서 같이 자고 있던데 ㅠㅠ 귀여워",
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
                                      "1",
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
                    )
                  ],
                )
              : const Center(
                child: CircularProgressIndicator(),
              ),
        ),
      ),
    );
  }
}
