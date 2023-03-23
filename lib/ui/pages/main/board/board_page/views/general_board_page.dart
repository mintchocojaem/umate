import 'package:danvery/routes/app_routes.dart';
import 'package:danvery/ui/pages/main/board/board_page/controller/board_page_controller.dart';
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
      () => controller.postController.isLoadGeneralPostListBoard
          ? SingleChildScrollView(
              //여기 obx 넣고 중앙에 로딩 띄워야함
              child: Column(
              children: [
                ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    padding: const EdgeInsets.only(
                        top: 8, bottom: 8, left: 16, right: 16),
                    itemCount: controller.postController.generalPostListHome.length,
                    itemBuilder: (BuildContext context, int index) {
                      return GestureDetector(
                        onTap: () {
                          Get.toNamed(Routes.post,
                              arguments: controller
                                  .postController.generalPostListHome[index].id);
                        },
                        child: Container(
                          color: Palette.pureWhite,
                          child: Column(
                            children: [
                              PostCard(
                                nickname: controller
                                    .postController.generalPostListHome[index].author,
                                title: controller
                                    .postController.generalPostListHome[index].title,
                                subtitle: controller
                                    .postController.generalPostListHome[index].body,
                                publishDate: controller.postController
                                    .generalPostListHome[index].createdAt,
                                commentCount: controller.postController
                                    .generalPostListHome[index].commentCount,
                                likeCount: controller.postController
                                    .generalPostListHome[index].likes,
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
