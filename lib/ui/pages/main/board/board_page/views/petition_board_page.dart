import 'package:danvery/utils/theme/palette.dart';
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
      () => controller.isLoadPetitionListBoard
          ? SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                        top: 8, bottom: 8, left: 16, right: 16),
                    child: CategoryButtonBar(
                      selectedIndex: controller.selectedCategory,
                      categories:
                      controller.categoryKORList,
                      selectedBackGroundColor: Palette.blue,
                      unSelectedBackGroundColor: Palette.white,
                      selectedTextColor: Palette.pureWhite,
                      unSelectedTextColor: Palette.grey,
                      onTap: (value) async {
                        controller.selectedCategory = value;
                      },
                    ),
                  ),
                  ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: controller.petitionListBoard.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Padding(
                          padding: const EdgeInsets.only(
                              top: 8.0, bottom: 8, left: 16, right: 16),
                          child: GestureDetector(
                            onTap: () {
                              Get.toNamed(Routes.petition,
                                  arguments: controller.petitionListBoard[index].id);
                            },
                            child: PetitionCard(
                                title: controller.petitionListBoard[index].title,
                                createdAt: controller.petitionListBoard[index].createdAt,
                                expiredAt: controller.petitionListBoard[index].expiresAt,
                                numberOfPeople: "143",
                                status: controller.petitionListBoard[index].status
                            ),
                          ),
                        );
                      }),
                ],
              ),
            )
          : const Center(
              child: CircularProgressIndicator(),
            ),
    );
  }
}
