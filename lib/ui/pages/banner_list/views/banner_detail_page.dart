import 'package:danvery/core/theme/app_text_theme.dart';
import 'package:danvery/core/theme/palette.dart';
import 'package:danvery/ui/pages/banner_list/controller/banner_page_controller.dart';
import 'package:danvery/ui/widgets/app_bar/transparent_app_bar.dart';
import 'package:danvery/ui/widgets/modern/modern_form_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher_string.dart';

class BannerDetailPage extends GetView<BannerPageController> {
  final VoidCallback? onTap;

  const BannerDetailPage({super.key, this.onTap});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      extendBodyBehindAppBar: false,
      appBar: TransparentAppBar(
        isDarkMode: Get.isDarkMode,
        title: "상세보기",
        automaticallyImplyLeading: true,
        onPressedLeading: () => Get.back(),
      ),
      body: Stack(
        children: [
          Center(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Image.network(
                    controller.bannerModel!.detailUrl,
                    errorBuilder: (context, error, stackTrace) {
                      return const Text(
                        "이미지를 불러오지 못했습니다",
                        style: regularStyle,
                      );
                    },
                    loadingBuilder: (context, child, loadingProgress) {
                      if (loadingProgress == null) return child;
                      return CircularProgressIndicator(
                        color: Palette.blue,
                        value: loadingProgress.expectedTotalBytes != null
                            ? loadingProgress.cumulativeBytesLoaded /
                                loadingProgress.expectedTotalBytes!
                            : null,
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
          controller.bannerModel!.actionUrl != null
              ? Positioned.fill(
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: Padding(
                      padding: EdgeInsets.only(
                        left: 32,
                        right: 32,
                        bottom: Get.mediaQuery.padding.bottom + 16,
                      ),
                      child: ModernFormButton(
                        elevation: 1,
                        enabledBackgroundColor: Palette.blue,
                        enabledTextColor: Palette.white,
                        text: "EVENT 참여하기",
                        onPressed: () async {
                          launchUrlString(controller.bannerModel!.actionUrl!);
                        },
                      ),
                    ),
                  ),
                )
              : const SizedBox(),
        ],
      ),
    );
  }
}
