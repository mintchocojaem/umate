import 'package:danvery/core/theme/palette.dart';
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
    controller.currentScrollPosition.value = 0;
    // TODO: implement build
    return Obx(
      () => Scaffold(
        appBar: MainAppBar(
          backGroundColor:
              Palette.blue.withOpacity(controller.currentScrollPosition.value),
          isWhite: true,
          isDarkMode: !Get.isDarkMode,
          actions: [
            IconButton(
              onPressed: () {
                Get.toNamed(Routes.postSearch);
              },
              icon: Icon(
                Icons.search,
                color: Palette.pureWhite,
              ),
            ),
          ],
        ),
        extendBodyBehindAppBar: true,
        backgroundColor: Palette.pureWhite,
        body: SingleChildScrollView(
          controller: controller.scrollController,
          child: Stack(
            children: [
              Stack(
                children: [
                  controller.bannerList.value.bannerList.isNotEmpty
                      ? AnimatedSwitcher(
                          duration: const Duration(seconds: 1),
                          child: InkWell(
                            key: ValueKey<int>(
                                controller.currentBannerIndex.value),
                            child: Image.network(
                              controller
                                  .bannerList
                                  .value
                                  .bannerList[
                                      controller.currentBannerIndex.value]
                                  .bannerUrl,
                              errorBuilder: (BuildContext context,
                                  Object exception, StackTrace? stackTrace) {
                                return Container(
                                  color: Palette.blue,
                                  height: 434,
                                  width: double.infinity,
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                      bottom: 84,
                                    ),
                                    child: Center(
                                      child: Text(
                                        '이미지를 불러오지 못했습니다',
                                        style: regularStyle.copyWith(
                                          color: Palette.white,
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              },
                              loadingBuilder: (BuildContext context,
                                  Widget child,
                                  ImageChunkEvent? loadingProgress) {
                                if (loadingProgress == null) {
                                  return child;
                                }
                                return Container(
                                  color: Palette.blue,
                                  height: 434,
                                  width: double.infinity,
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                      bottom: 84,
                                    ),
                                    child: Center(
                                      child: CircularProgressIndicator(
                                        color: Palette.white,
                                        value: loadingProgress
                                                    .expectedTotalBytes !=
                                                null
                                            ? loadingProgress
                                                    .cumulativeBytesLoaded /
                                                loadingProgress
                                                    .expectedTotalBytes!
                                            : null,
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),
                            onTap: () {
                              Get.toNamed(
                                Routes.bannerDetail,
                                arguments:
                                    controller.bannerList.value.bannerList[
                                        controller.currentBannerIndex.value],
                              );
                            },
                          ),
                        )
                      : Container(
                          color: Palette.blue,
                          height: 434,
                          width: double.infinity,
                          child: Padding(
                            padding: const EdgeInsets.only(
                              bottom: 84,
                            ),
                            child: Center(
                              child: CircularProgressIndicator(
                                color: Palette.white,
                              ),
                            ),
                          ),
                        ),
                ],
              ),
              Column(
                children: [
                  const SizedBox(
                    height: 260,
                  ),
                  Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: controller.mainButtons),
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: BoardList(
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
                              minimumSize: const Size(48, 18),
                              maximumSize: const Size(48, 18),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              side: BorderSide(width: 1.0, color: Palette.blue),
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
                              "Beta",
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
                              controller
                                      .bannerList.value.subBannerList.isNotEmpty
                                  ? Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 16),
                                      child: AnimatedSwitcher(
                                        duration: const Duration(seconds: 1),
                                        child: BannerCard(
                                          showDetail: true,
                                          currentBannerIndex: controller
                                                  .currentBannerIndex.value +
                                              1,
                                          totalBannerCount: controller
                                              .bannerList
                                              .value
                                              .subBannerList
                                              .length,
                                          key: ValueKey<int>(controller
                                              .currentBannerIndex.value),
                                          imageUrl: controller
                                              .bannerList
                                              .value
                                              .subBannerList[controller
                                                  .currentBannerIndex.value]
                                              .bannerUrl,
                                          onTap: () {
                                            Get.toNamed(
                                              Routes.bannerDetail,
                                              arguments: controller.bannerList
                                                      .value.subBannerList[
                                                  controller.currentBannerIndex
                                                      .value],
                                            );
                                          },
                                          onTapDetail: () {
                                            Get.toNamed(
                                              Routes.bannerList,
                                            );
                                          },
                                        ),
                                      ),
                                    )
                                  : const SizedBox(
                                      height: 16,
                                    ),
                              //get suggestion board with Obx
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 16),
                                child: BoardList(
                                  cards: controller
                                          .isLoadGeneralPostListHome.value
                                      ? [
                                          for (var i = 0;
                                              i <
                                                  controller.generalPostListHome
                                                      .length;
                                              i++)
                                            BoardCard(
                                              title: controller
                                                  .generalPostListHome[i].title,
                                              leadingText: controller
                                                  .generalPostListHome[i]
                                                  .createdAt,
                                              onTap: () {
                                                controller.mainPageController
                                                    .selectedIndex.value = 2;
                                                controller.boardPageController
                                                    .selectedTap.value = 0;
                                                Get.toNamed(Routes.post,
                                                    arguments: controller
                                                        .generalPostListHome[i]
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
                                    mainAxisAlignment: MainAxisAlignment.center,
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
                                    controller.mainPageController.selectedIndex
                                        .value = 2;
                                    controller.boardPageController.selectedTap
                                        .value = 0;
                                  },
                                ),
                              ),
                              //get petition board with Obx
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 16, horizontal: 16),
                                child: BoardList(
                                  cards: controller.isLoadPetitionListHome.value
                                      ? [
                                          for (var i = 0;
                                              i <
                                                  controller
                                                      .petitionListHome.length;
                                              i++)
                                            BoardCard(
                                              title: controller
                                                  .petitionListHome[i].title,
                                              leadingText: controller
                                                  .petitionListHome[i]
                                                  .createdAt,
                                              onTap: () {
                                                controller.mainPageController
                                                    .selectedIndex.value = 2;
                                                controller.boardPageController
                                                    .selectedTap.value = 1;
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
                                    mainAxisAlignment: MainAxisAlignment.center,
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
                                    controller.mainPageController.selectedIndex
                                        .value = 2;
                                    controller.boardPageController.selectedTap
                                        .value = 1;
                                  },
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ],
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
