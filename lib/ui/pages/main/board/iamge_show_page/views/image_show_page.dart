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
        body: Stack(
          children: [
            InkWell(
              splashColor: Colors.transparent,
              highlightColor: Colors.transparent,
              onTap: () {
                controller.showAppBar.value = !controller.showAppBar.value;
              },
              child: PageView.builder(
                controller: controller.pageController,
                itemCount: controller.imageList.length,
                itemBuilder: (context, index) {
                  return Image.file(controller.imageList[index],fit: BoxFit.fitWidth,);
                },
                onPageChanged: (index) {
                  controller.imageIndex.value = index;
                },
              ),
            ),
            Obx(
              () => controller.showAppBar.value
                  ? SizedBox(
                      height: 100,
                      child: AppBar(
                        elevation: 0,
                        backgroundColor: Palette.black.withOpacity(0.8),
                        title: Text(
                          "${controller.imageIndex.value + 1} / ${controller.imageList.length}",
                        ),
                        automaticallyImplyLeading: false,
                        leading: IconButton(
                          splashColor: Colors.transparent,
                          highlightColor: Colors.transparent,
                          icon: const Icon(Icons.arrow_back_ios),
                          onPressed: () {
                            Get.back();
                          },
                        ),
                      ),
                    )
                  : const SizedBox(),
            ),
          ],
        ));
  }
}
