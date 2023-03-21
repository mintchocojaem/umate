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
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
              padding: const EdgeInsets.only(
                  top: 8, bottom: 8, left: 16, right: 16),
              child: Obx(
                    () => CategoryButtonBar(
                  selectedIndex: controller.selectedCategory,
                  categories: const ["청원중", "답변대기중", "답변완료", "기간만료"],
                  selectedBackGroundColor: Palette.blue,
                  unSelectedBackGroundColor: Palette.white,
                  selectedTextColor: Palette.pureWhite,
                  unSelectedTextColor: Palette.grey,
                  onTap: (value) {
                    controller.selectedCategory = value;
                  },
                ),
              )),
          ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount:
              controller.petitionController.petitionBoard.length,
              itemBuilder: (BuildContext context, int index) {
                return Padding(
                  padding: const EdgeInsets.only(
                      top: 8.0, bottom: 8, left: 16, right: 16),
                  child: GestureDetector(
                    onTap: () {
                      Get.toNamed(
                          Routes.petition,
                          arguments: controller.petitionController
                              .petitionBoard[index].id);
                    },
                    child: PetitionCard(
                      title: controller.petitionController
                          .petitionBoard[index].title,
                      expiresAt: "D - 30",
                      petitionPeriod: "2023-01-15 ~ 2023-02-15",
                      numberOfPeople: "143",
                      status: "답변완료",
                    ),
                  ),
                );
              }),
        ],
      ),
    );
  }
}
