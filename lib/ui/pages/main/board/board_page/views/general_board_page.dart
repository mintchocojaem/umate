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
          ? controller.generalPostList.isEmpty
              ? Center(
                  child: Text(
                    '연관된 게시물이 존재하지 않습니다',
                    style: smallTitleStyle.copyWith(color: Palette.grey),
                  ),
                )
              : RefreshIndicator(
                  color: Palette.blue,
                  onRefresh: () async {
                    controller.getFirstGeneralPostBoard();
                  },
                  child: SingleChildScrollView(
                    controller: controller.generalBoardScrollController,
                    child: ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      padding: const EdgeInsets.only(
                          top: 8, bottom: 8, left: 16, right: 16),
                      itemCount: controller.generalPostList.length + 1,
                      itemBuilder: (BuildContext context, int index) {
                        if (index == controller.generalPostList.length) {
                          if (controller.generalPostBoard.value.last) {
                            return const SizedBox();
                          } else {
                            return const Padding(
                              padding: EdgeInsets.all(16.0),
                              child: Center(child: CircularProgressIndicator()),
                            );
                          }
                        }
                        return Container(
                          color: Palette.pureWhite,
                          child: Column(
                            children: [
                              PostCard(
                                  nickname:
                                      controller.generalPostList[index].author,
                                  title:
                                      controller.generalPostList[index].title,
                                  subtitle:
                                      controller.generalPostList[index].body,
                                  publishDate: controller
                                      .generalPostList[index].createdAt,
                                  commentCount: controller
                                      .generalPostList[index].commentCount,
                                  likeCount:
                                      controller.generalPostList[index].likes,
                                  imageUrl: controller.generalPostList[index]
                                          .files.isNotEmpty
                                      ? controller
                                          .generalPostList[index].files[0].url
                                      : null,
                                  onTap: () {
                                    Get.toNamed(Routes.post,
                                            arguments: controller
                                                .generalPostList[index].id)
                                        ?.then((value) {
                                      if (value != null) {
                                        final generalPostModel = value as GeneralPostModel;
                                        controller.generalPostList[index] = generalPostModel;
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
                  ),
                )
          : const Center(
              child: CircularProgressIndicator(),
            ),
    );
  }
}
