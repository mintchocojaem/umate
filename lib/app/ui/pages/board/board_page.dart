import 'package:danvery/app/ui/pages/board/category_board_page.dart';
import 'package:danvery/app/ui/pages/board/petition_board_page.dart';
import 'package:danvery/app/ui/theme/app_colors.dart';
import 'package:danvery/app/ui/widgets/board/board_card.dart';
import 'package:danvery/app/ui/widgets/board/board_list.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BoardPage extends GetView {
  const BoardPage({super.key});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return DefaultTabController(
      length: 2,
      child: NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) {
          return [
            const SliverAppBar(
              pinned: false,
              backgroundColor: Colors.white,
              title: Text(
                "게시판",
                style: TextStyle(color: Colors.black),
              ),
            ),
            const SliverPersistentHeader(
                pinned: true, delegate: TabBarDelegate()),
          ];
        },
        body: TabBarView(
          children: [
            CategoryBoardPage(),
            Container(),
          ],
        ),
      ),
    );
  }
}

class TabBarDelegate extends SliverPersistentHeaderDelegate {
  const TabBarDelegate();

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      color: Colors.white,
      child: TabBar(
        tabs: [
          Tab(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              color: Colors.white,
              child: const Text(
                "자유게시판",
              ),
            ),
          ),
          Tab(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              color: Colors.white,
              child: const Text(
                "청원게시판",
              ),
            ),
          ),
        ],
        indicatorWeight: 2,
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        unselectedLabelColor: Colors.grey,
        labelColor: Colors.black,
        indicatorColor: Colors.black,
        indicatorSize: TabBarIndicatorSize.label,
      ),
    );
  }

  @override
  double get maxExtent => 48;

  @override
  double get minExtent => 48;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    return false;
  }
}
