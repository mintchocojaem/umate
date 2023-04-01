import 'package:danvery/core/theme/palette.dart';
import 'package:danvery/routes/app_routes.dart';
import 'package:danvery/core/theme/app_text_theme.dart';
import 'package:danvery/ui/pages/main/board/board_page/controller/board_page_controller.dart';
import 'package:danvery/ui/pages/main/board/board_page/views/petition_board_page.dart';
import 'package:danvery/ui/widgets/app_bar/main_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'general_board_page.dart';

class BoardPage extends GetView<BoardPageController> {
  const BoardPage({super.key});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return DefaultTabController(
      length: 2,
      initialIndex: controller.selectedTap.value,
      child: Scaffold(
        backgroundColor: Palette.pureWhite,
        appBar: MainAppBar(
          isDarkMode: Get.isDarkMode,
          backGroundColor: Palette.pureWhite,
          height: 60,
          actions: [
            Obx(
              () => IntrinsicWidth(
                child: TextField(
                  style: regularStyle.copyWith(
                    color: Palette.lightBlack,
                    fontWeight: FontWeight.bold,
                  ),
                  maxLines: 1,
                  readOnly: true,
                  controller: TextEditingController(text: controller.searchText.value),
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    suffixIcon: controller.searchText.isEmpty ? IconButton(
                      onPressed: () {
                        Get.toNamed(Routes.postSearch);
                      },
                      icon: Icon(
                        Icons.search,
                        color: Palette.blue,
                      ),
                    ) : IconButton(
                      onPressed: () {
                        controller.searchText.value = '';
                        controller.getFirstGeneralPostBoard();
                      },
                      icon: Icon(
                        Icons.cancel,
                        color: Palette.grey,
                      ),
                    ),
                  ),
                ),
              )
            ),
          ],
        ),
        body: Column(
          children: [
            DecoratedBox(
              decoration: BoxDecoration(
                //This is for bottom border that is needed
                border: Border(
                    bottom: BorderSide(color: Palette.white, width: 2)),
              ),
              child: TabBar(
                indicatorColor: Palette.blue,
                unselectedLabelColor: Palette.grey,
                labelColor: Palette.blue,
                tabs: const [
                  Tab(
                    child: Text(
                      "자유게시판",
                      style: regularStyle,
                    ),
                  ),
                  Tab(
                    child: Text(
                      "청원게시판",
                      style: regularStyle,
                    ),
                  ),
                ],
              ),
            ),
            const Expanded(
              child: TabBarView(
                //physics: NeverScrollableScrollPhysics(),
                // to disable TabBar scrolling
                children: [
                  GeneralBoardPage(),
                  PetitionBoardPage(),
                ],
              ),
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: Palette.blue,
          onPressed: () {
            Get.toNamed(Routes.postWrite);
          },
          child: const Icon(
            Icons.add_rounded,
            size: 30,
          ),
        ),
      ),
    );
  }
}
