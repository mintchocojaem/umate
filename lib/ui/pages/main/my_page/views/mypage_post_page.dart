import 'package:danvery/routes/app_routes.dart';
import 'package:danvery/ui/pages/banner_list/controller/banner_list_page_controller.dart';
import 'package:danvery/ui/pages/banner_list/views/banner_card.dart';
import 'package:danvery/ui/pages/main/my_page/controller/mypage_page_controller.dart';
import 'package:danvery/ui/widgets/app_bar/transparent_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MyPagePostPage extends GetView<MyPagePageController> {
  const MyPagePostPage({super.key});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    controller.myPagePostTitle =
        ["내가 게시한 글", "내가 댓글 단 글", "내가 좋아요한 글"][controller.myPagePostIndex];
    return Scaffold(
      appBar: TransparentAppBar(
        isDarkMode: Get.isDarkMode,
        title: controller.myPagePostTitle,
        automaticallyImplyLeading: true,
        onPressedLeading: () => Get.back(),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Container()
      ),
    );
  }
}
