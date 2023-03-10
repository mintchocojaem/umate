import 'package:danvery/app/ui/pages/board/general_board_page.dart';
import 'package:danvery/app/ui/theme/app_text_theme.dart';
import 'package:danvery/app/ui/theme/palette.dart';
import 'package:danvery/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BoardScreen extends GetView {
  const BoardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return DefaultTabController(
      length: 2,
      initialIndex: 1,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Palette.pureWhite,
          elevation: 0,
          title: Text("Danvery",style: titleStyle.copyWith(color: Palette.blue),),
          centerTitle: false,
          automaticallyImplyLeading: false,
          actions: [
            IconButton(
                onPressed: () {
                  Get.toNamed(Routes.searchBoard);
                },
                icon: Icon(
                  Icons.search,
                  color: Palette.grey,
                )
            ),
            SizedBox(width: 8,)
          ],
          bottom: TabBar(
            indicatorColor: Palette.blue,
            tabs: [
              Tab(
                child: Text("자유게시판",style: regularStyle.copyWith(color: Palette.blue),),
              ),
              Tab(
                child: Text("청원게시판",style: regularStyle.copyWith(color: Palette.blue),),
              ),
            ],
          ),
        ),
        body: TabBarView(
         children: [
           GeneralBoardPage(),
           Container()
         ],
        )
      ),
    );
  }
}
