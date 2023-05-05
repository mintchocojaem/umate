import 'package:danvery/core/theme/palette.dart';
import 'package:danvery/domain/board/post/general_post/model/general_post_model.dart';
import 'package:danvery/routes/app_routes.dart';
import 'package:danvery/ui/pages/main/board/board_page/controller/board_page_controller.dart';
import 'package:danvery/core/theme/app_text_theme.dart';
import 'package:danvery/ui/widgets/board/post_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class GeneralBoardPage extends GetView<BoardPageController> {
  const GeneralBoardPage({super.key});

  @override
  Widget build(BuildContext context) {
    controller.selectedTap.value = 0;
    return Obx(
      () => controller.isLoadGeneralPostBoard.value &&
              controller.isLoadedImageList.value
          ? controller.generalPostBoard.value.generalPosts.isEmpty
              ? Center(
                  child: Text(
                    '연관된 게시물이 존재하지 않습니다',
                    style: smallTitleStyle.copyWith(color: Palette.grey),
                  ),
                )
              : RefreshIndicator(
                  color: Palette.blue,
                  onRefresh: () async {
                    await controller.getGeneralPostBoardWithRefresh(true);
                  },
                  child: ListView.builder(
                    key: const PageStorageKey('generalPostList'),
                    controller: controller.generalBoardScrollController,
                    shrinkWrap: true,
                    padding: const EdgeInsets.only(
                        top: 8, bottom: 8, left: 16, right: 16),
                    itemCount: controller.generalPostBoard.value.generalPosts.length + 1,
                    itemBuilder: (BuildContext context, int index) {
                      final generalPostBoard = controller.generalPostBoard.value;
                      if (index == generalPostBoard.generalPosts.length) {
                        if (generalPostBoard.last) {
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
                                nickname: generalPostBoard.generalPosts[index].author,
                                title: generalPostBoard.generalPosts[index].title,
                                subtitle: generalPostBoard.generalPosts[index].body,
                                publishDate: generalPostBoard.generalPosts[index].createdAt,
                                commentCount:
                                    generalPostBoard.generalPosts[index].commentCount,
                                likeCount: generalPostBoard.generalPosts[index].likes,
                                imageUrl: generalPostBoard.generalPosts[index]
                                        .files
                                        .map((e) => e.mimeType.contains('image')
                                            ? e.thumbnailUrl
                                            : null)
                                        .whereType<String>()
                                        .isNotEmpty
                                    ? generalPostBoard.generalPosts[index]
                                        .files
                                        .map((e) => e.mimeType.contains('image')
                                            ? e.thumbnailUrl
                                            : null)
                                        .whereType<String>()
                                        .first
                                    : null,
                                onTap: () {
                                  Get.toNamed(Routes.post,
                                          arguments: generalPostBoard.generalPosts[index].id)
                                      ?.then((value) {
                                    if (value != null) {
                                      final generalPostModel =
                                          value as GeneralPostModel;
                                      generalPostBoard.generalPosts[index] = generalPostModel;
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
                  ),
                )
          : const Center(
              child: CircularProgressIndicator(),
            ),
    );
  }
}
