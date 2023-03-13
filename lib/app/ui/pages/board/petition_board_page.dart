import 'package:danvery/app/ui/theme/palette.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../widgets/board/category_button_bar.dart';
import '../../widgets/board/post/pettition_card.dart';

class PetitionBoardPage extends GetView {
  const PetitionBoardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 16, right: 16, top: 8, bottom: 8),
            child: CategoryButtonBar(
              categories: const ["청원중", "답변대기중", "답변완료","기간만료"],
              selectedBackGroundColor: Palette.blue,
              unSelectedBackGroundColor: Palette.white,
              selectedTextColor: Palette.pureWhite,
              unSelectedTextColor: Palette.grey,
            ),
          ),
          ListView.builder(
              shrinkWrap: true,
              itemCount: 4,
              itemBuilder: (BuildContext context, int index) {
                return const Padding(
                  padding: EdgeInsets.only(top: 8.0, bottom: 8, left: 16, right: 16),
                  child: PetitionCard(
                    title: "셔틀버스 실시간 위치 정보 공유 청원",
                    dueDate: "D - 30",
                    petitionPeriod: "2023-01-15 ~ 2023-02-15",
                    numberOfPeople: "143",
                    petitionStatus: "답변완료",
                  ),
                );
              }
          ),
        ],
      ),
    );
  }
}
