import 'package:danvery/routes/app_routes.dart';
import 'package:danvery/ui/pages/banner_list/controller/banner_list_page_controller.dart';
import 'package:danvery/ui/pages/banner_list/views/banner_card.dart';
import 'package:danvery/ui/widgets/app_bar/transparent_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BannerListPage extends GetView<BannerListPageController> {
  final VoidCallback? onTap;

  const BannerListPage({super.key, this.onTap});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: TransparentAppBar(
        isDarkMode: Get.isDarkMode,
        title: "제휴 이벤트",
        automaticallyImplyLeading: true,
        onPressedLeading: () => Get.back(),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: ListView.builder(
          itemCount: controller.bannerListModel.subBannerList.length,
          itemBuilder: (BuildContext context, int index) {
            return Column(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: BannerCard(
                    currentBannerIndex: index + 1,
                    totalBannerCount:
                        controller.bannerListModel.subBannerList.length,
                    onTap: () {
                      controller.setBannerModel(
                          controller.bannerListModel.subBannerList[index]);
                      Get.toNamed(Routes.bannerDetail);
                    },
                    imageUrl: controller
                        .bannerListModel.subBannerList[index].bannerUrl,
                  ),
                ),
                const SizedBox(
                  height: 16,
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
