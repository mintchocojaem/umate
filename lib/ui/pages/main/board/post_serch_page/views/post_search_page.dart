import 'package:danvery/ui/widgets/app_bar/seacrh_app_bar.dart';
import 'package:danvery/utils/theme/app_text_theme.dart';
import 'package:danvery/utils/theme/palette.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PostSearchPage extends GetView {
  const PostSearchPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          SearchAppBar(
            backGroundColor: Palette.transparent,
            isDarkMode: Get.isDarkMode,
            hint: '글의 제목, 내용, 키워드를 입력하세요',
            onPressedLeading: () => Get.back(),
          ),
          Positioned.fill(
            child: Align(
              alignment: Alignment.center,
              child: Text(
                '게시판에서 원하는 글을 검색해보세요',
                style: titleStyle.copyWith(color: Palette.grey),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
