import 'package:danvery/core/theme/app_text_theme.dart';
import 'package:danvery/core/theme/palette.dart';
import 'package:danvery/ui/pages/main/board/board_page/controller/board_page_controller.dart';
import 'package:danvery/ui/widgets/board/category_button_bar.dart';
import 'package:danvery/ui/widgets/board/pettition_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../../routes/app_routes.dart';

class PetitionBoardPage extends GetView<BoardPageController> {
  const PetitionBoardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => controller.isLoadPetitionBoard.value
          ? Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                      top: 8, bottom: 8, left: 16, right: 16),
                  child: CategoryButtonBar(
                    selectedIndex: controller.selectedCategory.value,
                    categories: controller.categoryKORList,
                    selectedBackGroundColor: Palette.blue,
                    unSelectedBackGroundColor: Palette.white,
                    selectedTextColor: Palette.pureWhite,
                    unSelectedTextColor: Palette.grey,
                    onTap: (value) async {
                      controller.selectedCategory.value = value;
                    },
                  ),
                ),
                Expanded(
                  child: controller.petitionPostList.isEmpty
                      ? Center(
                          child: Text(
                            '연관된 게시물이 존재하지 않습니다',
                            style: titleStyle.copyWith(color: Palette.grey),
                          ),
                        )
                      : RefreshIndicator(
                          color: Palette.blue,
                          onRefresh: () async {
                            controller.getPetitionPostListBoard();
                          },
                          child: SingleChildScrollView(
                            controller: controller.petitionBoardScrollController,
                            child: ListView.builder(
                                physics: const NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                itemCount:
                                    controller.petitionPostList.length + 1,
                                itemBuilder: (BuildContext context, int index) {
                                  if (index ==
                                      controller.petitionPostList.length) {
                                    if (controller.petitionBoard.value.last) {
                                      return const SizedBox();
                                    } else {
                                      return const Padding(
                                        padding: EdgeInsets.all(16.0),
                                        child: Center(
                                            child: CircularProgressIndicator()),
                                      );
                                    }
                                  }
                                  return Padding(
                                    padding: const EdgeInsets.only(
                                        top: 8.0,
                                        bottom: 8,
                                        left: 16,
                                        right: 16),
                                    child: GestureDetector(
                                      onTap: () {
                                        Get.toNamed(Routes.petition,
                                            arguments: controller
                                                .petitionPostList[index].id);
                                      },
                                      child: PetitionCard(
                                          title: controller
                                              .petitionPostList[index].title,
                                          createdAt: controller
                                              .petitionPostList[index]
                                              .createdAt,
                                          expiredAt: controller
                                              .petitionPostList[index]
                                              .expiresAt,
                                          numberOfPeople: "143",
                                          status: controller
                                              .petitionPostList[index].status),
                                    ),
                                  );
                                }),
                          ),
                        ),
                ),
              ],
            )
          : const Center(
              child: CircularProgressIndicator(),
            ),
    );
  }
}
