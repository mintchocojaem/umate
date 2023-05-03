import 'package:danvery/core/theme/palette.dart';
import 'package:danvery/domain/board/post/general_post/model/general_post_model.dart';
import 'package:danvery/routes/app_routes.dart';
import 'package:danvery/ui/pages/main/my_page/controller/mypage_page_controller.dart';
import 'package:danvery/ui/widgets/app_bar/transparent_app_bar.dart';
import 'package:danvery/ui/widgets/board/post_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MyPagePostPage extends GetView<MyPagePageController> {
  const MyPagePostPage({super.key});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      backgroundColor: Palette.pureWhite,
      appBar: TransparentAppBar(
        isDarkMode: Get.isDarkMode,
        title: controller.myPagePostType.title,
        automaticallyImplyLeading: true,
        onPressedLeading: () => Get.back(),
      ),
      body: Obx(
        () => controller.isLoadPost.value ? ListView.builder(
          controller: controller.scrollController,
          shrinkWrap: true,
          padding:
              const EdgeInsets.only(top: 8, bottom: 8, left: 16, right: 16),
          itemCount: controller.userPostList.value.generalPosts.length + 1,
          itemBuilder: (BuildContext context, int index) {
            if (index == controller.userPostList.value.generalPosts.length) {
              if (controller.userPostList.value.last) {
                return const SizedBox();
              } else {
                return const Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                );
              }
            }
            return Container(
              color: Palette.pureWhite,
              child: Column(
                children: [
                  PostCard(
                      nickname: controller
                          .userPostList.value.generalPosts[index].author,
                      title: controller
                          .userPostList.value.generalPosts[index].title,
                      subtitle: controller
                          .userPostList.value.generalPosts[index].body,
                      publishDate: controller
                          .userPostList.value.generalPosts[index].createdAt,
                      commentCount: controller
                          .userPostList.value.generalPosts[index].commentCount,
                      likeCount: controller
                          .userPostList.value.generalPosts[index].likes,
                      imageUrl: controller
                              .userPostList.value.generalPosts[index].files
                              .map((e) => e.mimeType.contains('image')
                                  ? e.thumbnailUrl
                                  : null)
                              .whereType<String>()
                              .isNotEmpty
                          ? controller
                              .userPostList.value.generalPosts[index].files
                              .map((e) => e.mimeType.contains('image')
                                  ? e.thumbnailUrl
                                  : null)
                              .whereType<String>()
                              .first
                          : null,
                      onTap: () {
                        Get.toNamed(Routes.post,
                                arguments: controller
                                    .userPostList.value.generalPosts[index].id)
                            ?.then((value) {
                          if (value != null) {
                            final generalPostModel = value as GeneralPostModel;
                            controller.userPostList.value.generalPosts[index] =
                                generalPostModel;
                          }
                        });
                      }),
                  Divider(
                    color: Palette.lightGrey,
                    thickness: 1,
                  ),
                ],
              ),
            );
          },
        ) : const SizedBox(
          height: 400,
          child: Center(
            child: CircularProgressIndicator(),
          ),
        ),
      ),
    );
  }
}
