import 'package:danvery/utils/theme/palette.dart';
import 'package:danvery/ui/pages/main/board/board_page/controllers/board_page_controller.dart';
import 'package:danvery/ui/widgets/board/category_button_bar.dart';
import 'package:danvery/ui/widgets/board/post/pettition_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../../domain/board/petition/controller/petition_controller.dart';



class PetitionBoardPage extends GetView {
  const PetitionBoardPage({super.key});

  @override
  Widget build(BuildContext context) {

    final PetitionController petitionController = Get.find<PetitionController>();
    final BoardPageController boardPageController = Get.find<BoardPageController>();

    return SingleChildScrollView(
      child: Obx(
        () => petitionController.isLoadPetitionBoard
            ? Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 8, bottom: 8, left: 16, right: 16),
                    child: Obx(()=>CategoryButtonBar(
                      selectedIndex: boardPageController.selectedCategory,
                      categories: const ["청원중", "답변대기중", "답변완료", "기간만료"],
                      selectedBackGroundColor: Palette.blue,
                      unSelectedBackGroundColor: Palette.white,
                      selectedTextColor: Palette.pureWhite,
                      unSelectedTextColor: Palette.grey,
                      onTap: (value) {
                        boardPageController.selectedCategory = value;
                      },
                    ),)
                  ),
                  ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: petitionController.petitionBoard.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Padding(
                          padding: const EdgeInsets.only(
                              top: 8.0, bottom: 8, left: 16, right: 16),
                          child: PetitionCard(
                            title: petitionController.petitionBoard[index].title,
                            dueDate: "D - 30",
                            petitionPeriod: "2023-01-15 ~ 2023-02-15",
                            numberOfPeople: "143",
                            petitionStatus: "답변완료",
                          ),
                        );
                      }),
                ],
              )
            : const SizedBox(
                height: 200,
                child: Center(child: CircularProgressIndicator()),
              ),
      ),
    );
  }
}
