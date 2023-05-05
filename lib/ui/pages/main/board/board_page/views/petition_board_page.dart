import 'package:danvery/core/theme/app_text_theme.dart';
import 'package:danvery/core/theme/palette.dart';
import 'package:danvery/domain/board/post/petition_post/model/petition_post_model.dart';
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
    controller.selectedTap.value = 1;
    return Obx(
      () => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding:
                const EdgeInsets.only(top: 8, bottom: 8, left: 16, right: 16),
            child: CategoryButtonBar(
              selectedIndex: controller.selectedCategory.value,
              categories:
                  PetitionPostStatus.values.map((e) => e.nameKR).toList(),
              selectedBackGroundColor: Palette.blue,
              unSelectedBackGroundColor: Palette.white,
              selectedTextColor: Palette.pureWhite,
              unSelectedTextColor: Palette.grey,
              onTap: (value) async{
                controller.selectedCategory.value = value;
              },
            ),
          ),
          Expanded(
            child: Obx(
              () => controller.isLoadPetitionBoard.value
                  ? RefreshIndicator(
                    color: Palette.blue,
                    onRefresh: () async {
                      controller.getPetitionPostBoardWithRefresh(true);
                    },
                    child: controller.petitionBoard.value.petitionPosts.isEmpty
                        ? CustomScrollView(
                            physics: const AlwaysScrollableScrollPhysics(),
                            slivers: [
                              SliverFillRemaining(
                                hasScrollBody: false,
                                child: Center(
                                  child: Text(
                                    '연관된 게시물이 존재하지 않습니다',
                                    style: smallTitleStyle.copyWith(
                                        color: Palette.grey),
                                  ),
                                ),
                              ),
                            ],
                          )
                        : ListView.builder(
                            key: const PageStorageKey('petitionBoard'),
                            controller:
                            controller.petitionBoardScrollController,
                            physics: const AlwaysScrollableScrollPhysics(),
                            itemCount:
                                controller.petitionBoard.value.petitionPosts.length + 1,
                            itemBuilder: (BuildContext context, int index) {
                              final petitionPostBoard = controller.petitionBoard.value;
                              if (index == petitionPostBoard.petitionPosts.length) {
                                if (petitionPostBoard.last) {
                                  return const SizedBox();
                                } else {
                                  return const Padding(
                                    padding: EdgeInsets.all(16.0),
                                    child: Center(
                                        child:
                                            CircularProgressIndicator(),
                                    ),
                                  );
                                }
                              }
                              return Padding(
                                padding: const EdgeInsets.only(
                                    top: 8.0,
                                    bottom: 8,
                                    left: 16,
                                    right: 16),
                                child: PetitionCard(
                                  tag: petitionPostBoard.petitionPosts[index]
                                      .tag.first.name,
                                  title: petitionPostBoard.petitionPosts[index].title,
                                  createdAt: petitionPostBoard.petitionPosts[index].createdAt,
                                  expiredAt: petitionPostBoard.petitionPosts[index].expiresAt,
                                  agreeCount:
                                      "${petitionPostBoard.petitionPosts[index].agreeCount}명",
                                  status: petitionPostBoard.petitionPosts[index].status,
                                  onTap: () {
                                    Get.toNamed(Routes.petition,
                                            arguments: petitionPostBoard.petitionPosts[index]
                                                .id)
                                        ?.then((value) {
                                      if (value != null) {
                                        final petitionPostModel =
                                            value as PetitionPostModel;
                                        petitionPostBoard.petitionPosts[index] =
                                            petitionPostModel;
                                      }
                                    });
                                  },
                                ),
                              );
                            }),
                  )
                  : const Center(
                      child: CircularProgressIndicator(),
                    ),
            ),
          ),
        ],
      ),
    );
  }
}
