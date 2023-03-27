import 'package:danvery/routes/app_routes.dart';
import 'package:danvery/ui/pages/main/board/board_page/controller/board_page_controller.dart';
import 'package:danvery/utils/theme/app_text_theme.dart';
import 'package:danvery/utils/theme/palette.dart';
import 'package:danvery/ui/widgets/board/post_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class GeneralBoardPage extends GetView<BoardPageController> {
  const GeneralBoardPage({super.key});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    return Obx(
      () => controller.isLoadGeneralPostListBoard
          ? controller.generalPostListBoard.isEmpty
              ? Center(
                  child: Text(
                    '연관된 게시물이 존재하지 않습니다',
                    style: titleStyle.copyWith(color: Palette.grey),
                  ),
                )
              : SingleChildScrollView(
                  //여기 obx 넣고 중앙에 로딩 띄워야함
                  child: Column(
                  children: [
                    ListView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        padding: const EdgeInsets.only(
                            top: 8, bottom: 8, left: 16, right: 16),
                        itemCount: controller.generalPostListBoard.length,
                        itemBuilder: (BuildContext context, int index) {
                          return GestureDetector(
                            onTap: () {
                              Get.toNamed(Routes.post,
                                  arguments: controller
                                      .generalPostListBoard[index].id);
                            },
                            child: Container(
                              color: Palette.pureWhite,
                              child: Column(
                                children: [
                                  PostCard(
                                    nickname: controller
                                        .generalPostListBoard[index].author,
                                    title: controller
                                        .generalPostListBoard[index].title,
                                    subtitle: controller
                                        .generalPostListBoard[index].body,
                                    publishDate: controller
                                        .generalPostListBoard[index].createdAt,
                                    commentCount: controller
                                        .generalPostListBoard[index]
                                        .commentCount,
                                    likeCount: controller
                                        .generalPostListBoard[index].likes,
                                  ),
                                  Divider(
                                    color: Palette.grey,
                                    height: 1,
                                  ),
                                ],
                              ),
                            ),
                          );
                        }),
                  ],
                ))
          : const Center(
              child: CircularProgressIndicator(),
            ),
    );
  }
}
