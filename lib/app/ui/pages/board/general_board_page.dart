import 'package:danvery/app/controller/board_controller.dart';
import 'package:danvery/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../theme/palette.dart';
import '../../widgets/board/post/post_card.dart';

class GeneralBoardPage extends GetView {
  const GeneralBoardPage({super.key});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    final BoardController boardController = Get.find<BoardController>();

    return SingleChildScrollView(
      child: Obx(() => boardController.isLoadGeneralBoard
          ? Column(
              children: [
                ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    padding: const EdgeInsets.only(top: 10, bottom: 10),
                    itemCount: boardController.generalBoard.length,
                    itemBuilder: (BuildContext context, int index) {
                      return GestureDetector(
                        onTap: (){
                          Get.toNamed(Routes.generalPost,
                              arguments:
                              boardController.generalBoard[index].id);
                        },
                        child: Container(
                          color: Palette.pureWhite,
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(left: 16, right: 16),
                                child: PostCard(
                                  title: boardController.generalBoard[index].title,
                                  subtitle: boardController.generalBoard[index].body,
                                  publishDate:
                                      boardController.generalBoard[index].createdDate,
                                  commentCount: 0,
                                  likeCount: 0,
                                ),
                              ),
                              Divider(color: Palette.grey,height: 0,),
                            ],
                          ),
                        ),
                      );
                    }),
              ],
            )
          : const SizedBox(
              height: 200,
              child: Center(child: CircularProgressIndicator()))),
    );
  }
}
