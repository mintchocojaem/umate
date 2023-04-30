import 'package:danvery/ui/pages/banner_list/controller/banner_list_controller.dart';
import 'package:danvery/ui/widgets/app_bar/transparent_app_bar.dart';
import 'package:danvery/ui/widgets/modern/modern_form_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher_string.dart';

class BannerDetailPage extends GetView<BannerListPageController> {
  final VoidCallback? onTap;

  const BannerDetailPage({super.key, this.onTap});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: TransparentAppBar(
        isDarkMode: Get.isDarkMode,
        title: "공지 및 이벤트",
        automaticallyImplyLeading: true,
        onPressedLeading: () => Get.back(),
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Image.network(
              controller.bannerModel.detailUrl,
              fit: BoxFit.fitWidth,
            ),
          ),
          controller.bannerModel.actionUrl != null ? Positioned.fill(
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: EdgeInsets.only(
                  left: 16,
                  right: 16,
                  bottom: Get.mediaQuery.padding.bottom + 16,
                ),
                child: ModernFormButton(
                    text: "이벤트 참여하기",
                    onPressed: () async {
                      launchUrlString(controller.bannerModel.actionUrl!);
                    },
                ),
              ),
            ),
          ) : const SizedBox(),
        ],
      ),
    );
  }
}
