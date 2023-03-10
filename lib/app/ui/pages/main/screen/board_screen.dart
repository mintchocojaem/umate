import 'package:danvery/app/ui/pages/board/general_board_page.dart';
import 'package:danvery/app/ui/pages/board/petition_board_page.dart';
import 'package:danvery/app/ui/theme/app_colors.dart';
import 'package:danvery/app/ui/theme/app_text_theme.dart';
import 'package:danvery/app/ui/widgets/app_bar/transparent_app_bar.dart';
import 'package:danvery/app/ui/widgets/board/board_card.dart';
import 'package:danvery/app/ui/widgets/board/board_list.dart';
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
          backgroundColor: white,
          elevation: 0,
          title: Text("Danvery",style: titleStyle.copyWith(color: blue),),
          centerTitle: false,
          automaticallyImplyLeading: false,
          actions: [
            IconButton(
                onPressed: () {
                  Get.toNamed(Routes.searchBoard);
                },
                icon: Icon(
                  Icons.search,
                  color: grey,
                )
            ),
            SizedBox(width: 8,)
          ],
          bottom: TabBar(
            indicatorColor: blue,
            tabs: [
              Tab(
                child: Text("자유게시판",style: regularStyle.copyWith(color: blue),),
              ),
              Tab(
                child: Text("청원게시판",style: regularStyle.copyWith(color: blue),),
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
