import 'package:danvery/app/controller/board_controller.dart';
import 'package:danvery/app/ui/widgets/app_bar/transparent_app_bar.dart';
import 'package:danvery/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../theme/app_colors.dart';
import '../../widgets/board/card/notice_card.dart';
import '../../widgets/board/card/post_card.dart';

class GeneralBoardPage extends GetView {
  const GeneralBoardPage({super.key});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    final BoardController boardController = Get.find<BoardController>();

    return Scaffold(
      appBar: TransparentAppBar(
        title: "자유게시판",
        automaticallyImplyLeading: true,
        onPressedLeading: () {
          Get.back();
        },
        actions: [
          IconButton(
              onPressed: () {
                Get.toNamed(Routes.searchBoard);
              },
              icon: Icon(
                Icons.search,
                color: grey,
              )),
          const SizedBox(
            width: 8,
          ),
          IconButton(
              onPressed: () {
                Get.toNamed(Routes.postCreate)?.then((value) => boardController.refreshGeneralBoard());
              },
              icon: Icon(
                Icons.post_add_outlined,
                color: grey,
              )),
          const SizedBox(
            width: 16,
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding:
              const EdgeInsets.only(right: 16, left: 16, top: 16, bottom: 16),
          child: Obx(() => boardController.isLoadGeneralBoard
              ? Column(
                  children: [
                    ListView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        padding: const EdgeInsets.only(top: 10, bottom: 10),
                        itemCount: 2,
                        itemBuilder: (BuildContext context, int index) {
                          return const NoticeCard(
                              category: "공지",
                              title: "내용",
                              commentCount: 0,
                              likeCount: 0);
                        }),
                    ListView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        padding: const EdgeInsets.only(top: 10, bottom: 10),
                        itemCount: boardController.generalBoard.length,
                        itemBuilder: (BuildContext context, int index) {
                          return PostCard(
                            title: boardController.generalBoard[index].title,
                            subtitle: boardController.generalBoard[index].body,
                            publishDate:
                                boardController.generalBoard[index].createdDate,
                            commentCount: 0,
                            likeCount: 0,
                            onTap: (){
                              Get.toNamed(Routes.generalPost, arguments: boardController.generalBoard[index].id);
                            },
                          );
                        }),
                  ],
                )
              : const SizedBox(
                  height: 200,
                  child: Center(child: CircularProgressIndicator()))),
        ),
      ),
    );
  }
}
