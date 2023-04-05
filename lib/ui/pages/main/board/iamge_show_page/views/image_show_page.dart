import 'package:danvery/core/theme/app_text_theme.dart';
import 'package:danvery/core/theme/palette.dart';
import 'package:danvery/ui/pages/main/board/iamge_show_page/controller/image_show_page_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ImageShowPage extends GetView<ImageShowPageController> {
  const ImageShowPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Palette.black,
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Palette.black,
          title: Obx(
            () => Text(
                "${controller.imageIndex.value + 1} / ${controller.imageList.length}",
            ),
          ),
          automaticallyImplyLeading: false,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios),
            onPressed: () {
              Get.back();
            },
          ),
        ),
        body: PageView.builder(
          controller: controller.pageController,
          itemCount: controller.imageList.length,
          itemBuilder: (context, index) {
            return Image.file(controller.imageList[index]);
          },
          onPageChanged: (index) {
            controller.imageIndex.value = index;
          },
        ));
  }
}
