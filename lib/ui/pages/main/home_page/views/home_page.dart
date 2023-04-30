import 'package:danvery/core/theme/palette.dart';
import 'package:danvery/domain/banner/provider/banner_provider.dart';
import 'package:danvery/routes/app_routes.dart';
import 'package:danvery/ui/pages/banner_list/views/banner_card.dart';
import 'package:danvery/ui/pages/main/home_page/controller/home_page_controller.dart';
import 'package:danvery/core/theme/app_text_theme.dart';
import 'package:danvery/ui/widgets/app_bar/main_app_bar.dart';
import 'package:danvery/ui/widgets/board/board_card.dart';
import 'package:danvery/ui/widgets/board/board_list.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomePage extends GetView<HomePageController> {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      backgroundColor: Palette.pureWhite,
      body: RefreshIndicator(
        onRefresh: () async {
          controller.getGeneralPostListHome();
          controller.getPetitionPostListHome();
          controller.getBannerList();
        },
        child: SingleChildScrollView(
          child: Stack(
            children: [
              Stack(
                children: [
                  Obx(
                    () => controller.isLoadBannerList.value
                        ? InkWell(
                            child: Image.network(
                              controller.bannerList.first.bannerUrl,
                            ),
                            onTap: () {
                              Get.toNamed(Routes.bannerDetail,
                                  arguments: controller.bannerList.first);
                            },
                          )
                        : Container(
                            color: Palette.blue,
                            height: 400,
                            child: Center(
                              child: Icon(
                                Icons.image_not_supported_outlined,
                                color: Palette.pureWhite,
                                size: 32,
                              ),
                            ),
                          ),
                  ),
                  SizedBox(
                    height: 60 + MediaQuery.of(context).padding.top,
                    child: MainAppBar(
                      backGroundColor: Palette.transparent,
                      isWhite: true,
                      isDarkMode: !Get.isDarkMode,
                    ),
                  ),
                ],
              ),
              Column(
                children: [
                  const SizedBox(
                    height: 260,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Column(
                      children: [
                        Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: controller.mainButtons),
                        const SizedBox(
                          height: 8,
                        ),
                        Obx(
                          () => BoardList(
                            cards: controller.isLoadBusList.value
                                ? controller.busCards
                                : [
                                    const SizedBox(
                                      height: 200,
                                      child: Center(
                                        child: CircularProgressIndicator(),
                                      ),
                                    ),
                                  ],
                            title: "버스 정보",
                            description: OutlinedButton(
                              style: OutlinedButton.styleFrom(
                                padding: EdgeInsets.zero,
                                minimumSize: const Size(64, 20),
                                maximumSize: const Size(64, 20),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                side:
                                    BorderSide(width: 1.0, color: Palette.blue),
                              ),
                              onPressed: () {
                                showCupertinoDialog(
                                  context: Get.context!,
                                  builder: (BuildContext context) {
                                    return CupertinoAlertDialog(
                                      title: const Text("버스 정보 안내"),
                                      content: const Text(
                                          "해당 기능은 실험 중이므로, 버스 예상 도착시간 정보가 정확하지 않을 수 있습니다."),
                                      actions: [
                                        CupertinoDialogAction(
                                          child: const Text(
                                            '확인',
                                          ),
                                          onPressed: () async {
                                            Get.back();
                                          },
                                        ),
                                      ],
                                    );
                                  },
                                );
                              },
                              child: Text(
                                "실험 기능",
                                style: tinyStyle.copyWith(
                                  color: Palette.blue,
                                  height: 1.1,
                                ),
                              ),
                            ),
                          ),
                        ),
                        Column(
                          children: [
                            Column(
                              children: [
                                //Banner
                                Padding(
                                  padding:
                                      const EdgeInsets.only(bottom: 8, top: 16),
                                  child: BannerCard(
                                    onTap: () {
                                      Get.toNamed(Routes.banner);
                                    },
                                  ),
                                ),
                                //get suggestion board with Obx
                                Obx(
                                  () => Padding(
                                    padding: const EdgeInsets.only(
                                        top: 8, bottom: 8),
                                    child: BoardList(
                                      cards: controller
                                              .isLoadGeneralPostListHome.value
                                          ? [
                                              for (var i = 0;
                                                  i <
                                                      controller
                                                          .generalPostListHome
                                                          .length;
                                                  i++)
                                                BoardCard(
                                                  title: controller
                                                      .generalPostListHome[i]
                                                      .title,
                                                  leadingText: controller
                                                      .generalPostListHome[i]
                                                      .createdAt,
                                                  onTap: () {
                                                    controller
                                                        .mainPageController
                                                        .selectedIndex
                                                        .value = 2;
                                                    controller
                                                        .boardPageController
                                                        .selectedTap
                                                        .value = 0;
                                                    Get.toNamed(Routes.post,
                                                        arguments: controller
                                                            .generalPostListHome[
                                                                i]
                                                            .id);
                                                  },
                                                ),
                                            ]
                                          : [
                                              const SizedBox(
                                                height: 200,
                                                child: Center(
                                                  child:
                                                      CircularProgressIndicator(),
                                                ),
                                              ),
                                            ],
                                      title: "자유 게시판",
                                      action: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            "더보기",
                                            style: regularStyle.copyWith(
                                                color: Palette.darkGrey,
                                                fontWeight: FontWeight.w500),
                                          ),
                                          Icon(
                                            Icons.arrow_forward_ios_outlined,
                                            color: Palette.darkGrey,
                                            size: regularStyle.fontSize,
                                          )
                                        ],
                                      ),
                                      onTapAction: () {
                                        controller.mainPageController
                                            .selectedIndex.value = 2;
                                        controller.boardPageController
                                            .selectedTap.value = 0;
                                      },
                                    ),
                                  ),
                                ),
                                //get petition board with Obx
                                Obx(
                                  () => Padding(
                                    padding: const EdgeInsets.only(
                                        top: 8, bottom: 8),
                                    child: BoardList(
                                      cards: controller
                                              .isLoadPetitionListHome.value
                                          ? [
                                              for (var i = 0;
                                                  i <
                                                      controller
                                                          .petitionListHome
                                                          .length;
                                                  i++)
                                                BoardCard(
                                                  title: controller
                                                      .petitionListHome[i]
                                                      .title,
                                                  leadingText: controller
                                                      .petitionListHome[i]
                                                      .createdAt,
                                                  onTap: () {
                                                    controller
                                                        .mainPageController
                                                        .selectedIndex
                                                        .value = 2;
                                                    controller
                                                        .boardPageController
                                                        .selectedTap
                                                        .value = 1;
                                                    Get.toNamed(Routes.petition,
                                                        arguments: controller
                                                            .petitionListHome[i]
                                                            .id);
                                                  },
                                                ),
                                            ]
                                          : [
                                              const SizedBox(
                                                height: 200,
                                                child: Center(
                                                  child:
                                                      CircularProgressIndicator(),
                                                ),
                                              ),
                                            ],
                                      title: "청원게시판",
                                      action: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            "더보기",
                                            style: regularStyle.copyWith(
                                                color: Palette.darkGrey,
                                                fontWeight: FontWeight.w500),
                                          ),
                                          Icon(
                                            Icons.arrow_forward_ios_outlined,
                                            color: Palette.darkGrey,
                                            size: regularStyle.fontSize,
                                          )
                                        ],
                                      ),
                                      onTapAction: () {
                                        controller.mainPageController
                                            .selectedIndex.value = 2;
                                        controller.boardPageController
                                            .selectedTap.value = 1;
                                      },
                                    ),
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
