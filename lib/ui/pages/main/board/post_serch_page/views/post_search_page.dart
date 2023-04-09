import 'package:danvery/core/theme/palette.dart';
import 'package:danvery/ui/pages/main/board/post_serch_page/controller/post_search_page_controller.dart';
import 'package:danvery/ui/widgets/app_bar/seacrh_app_bar.dart';
import 'package:danvery/core/theme/app_text_theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PostSearchPage extends GetView<PostSearchPageController> {
  const PostSearchPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          SearchAppBar(
            controller: controller.searchController,
            backGroundColor: Palette.transparent,
            isDarkMode: Get.isDarkMode,
            hint: '글의 제목, 내용, 키워드를 입력하세요',
            onPressedLeading: () => Get.back(),
            onSubmitted: (value) {
              controller.searchBoard();
            },
            onPressedSuffixIcon: () {
              controller.searchController.clear();
            },
          ),
          Positioned.fill(
            child: Align(
              alignment: Alignment.center,
              child: Text(
                '게시판에서 원하는 글을 검색해보세요',
                style: smallTitleStyle.copyWith(color: Palette.grey),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
