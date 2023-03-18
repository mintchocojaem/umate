import 'package:danvery/routes/app_routes.dart';
import 'package:danvery/utils/theme/palette.dart';
import 'package:danvery/ui/widgets/board/post/post_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../../domain/board/petition/controller/post_controller.dart';

class GeneralBoardPage extends GetView {
  const GeneralBoardPage({super.key});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    final PostController postController = Get.find<PostController>();

    return SingleChildScrollView(
      child: Obx(() => postController.isLoadGeneralBoard
          ? Column(
              children: [
                ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    padding: const EdgeInsets.only(top: 8, bottom: 8 , left: 16, right: 16),
                    itemCount: postController.generalBoard.length,
                    itemBuilder: (BuildContext context, int index) {
                      return GestureDetector(
                        onTap: (){
                          Get.toNamed(Routes.post, arguments: postController.generalBoard[index].id);
                        },
                        child: Container(
                          color: Palette.pureWhite,
                          child: Column(
                            children: [
                              PostCard(
                                title: postController.generalBoard[index].title,
                                subtitle: postController.generalBoard[index].body,
                                publishDate:
                                    "??",
                                commentCount: 0,
                                likeCount: 0,
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
