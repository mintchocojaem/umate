
import 'package:danvery/utils/theme/app_text_theme.dart';
import 'package:danvery/utils/theme/palette.dart';
import 'package:danvery/ui/pages/main/board/board_page/controller/board_page_controller.dart';
import 'package:danvery/ui/pages/main/board/board_page/views/petition_board_page.dart';
import 'package:danvery/ui/widgets/app_bar/main_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


import 'general_board_page.dart';

class BoardPage extends GetView {
  const BoardPage({super.key});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return DefaultTabController(
      length: 2,
      initialIndex: Get.find<BoardPageController>().selectedTap,
      child: Scaffold(
        backgroundColor: Palette.pureWhite,
        appBar: MainAppBar(
          isDarkMode: Get.isDarkMode,
          titleColor: Palette.blue,
          backGroundColor: Palette.pureWhite,
          height: 60,
        ),
        body: Column(
          children: [
            TabBar(
              indicatorColor: Palette.blue,
              unselectedLabelColor: Palette.grey,
              labelColor: Palette.blue,
              tabs: const [
                Tab(
                  child: Text("자유게시판",style: regularStyle,),
                ),
                Tab(
                  child: Text("청원게시판",style: regularStyle,),
                ),
              ],
            ),
            const Expanded(
              child: TabBarView(
                //physics: NeverScrollableScrollPhysics(),
                // to disable TabBar scrolling
                 children: [
                   GeneralBoardPage(),
                   PetitionBoardPage()
                 ],
              ),
            ),
          ],
        )
      ),
    );
  }
}
