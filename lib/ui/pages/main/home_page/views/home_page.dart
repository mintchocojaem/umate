import 'dart:async';

import 'package:danvery/core/theme/palette.dart';
import 'package:danvery/ui/pages/main/home_page/controller/home_page_controller.dart';
import 'package:danvery/core/theme/app_text_theme.dart';
import 'package:danvery/ui/pages/main/board/board_page/controller/board_page_controller.dart';
import 'package:danvery/ui/widgets/app_bar/main_app_bar.dart';
import 'package:danvery/ui/widgets/board/board_card.dart';
import 'package:danvery/ui/widgets/board/board_list.dart';
import 'package:danvery/ui/widgets/board/bus_card.dart';
import 'package:danvery/ui/widgets/banner/banner_card.dart';
import 'package:danvery/ui/widgets/circle_button/circle_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher_string.dart';

import '../../main_page/controller/main_page_controller.dart';

class HomePage extends GetView<HomePageController> {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      backgroundColor: Palette.pureWhite,
      appBar: MainAppBar(
        backGroundColor: Palette.blue,
        isWhite: true,
        isDarkMode: !Get.isDarkMode,
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          controller.getGeneralPostListHome();
          controller.getPetitionPostListHome();
        },
        child: Stack(
          children: [
            Container(
              height: Get.height / 2,
              color: Palette.blue,
            ),
            SingleChildScrollView(
              child: Stack(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(
                            top: 16, left: 16, right: 16, bottom: 8),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text.rich(
                              TextSpan(
                                style: regularStyle.copyWith(
                                    color: Palette.pureWhite),
                                text: '안녕하세요,\n', // default text style
                                children: <TextSpan>[
                                  TextSpan(
                                      text:
                                          "${controller.loginService.loginModel.major} ${controller.loginService.loginModel.studentId.substring(2, 4)}학번\n",
                                      style: titleStyle.copyWith(
                                          color: Palette.pureWhite)),
                                  TextSpan(
                                      text: controller
                                          .loginService.loginModel.userName,
                                      style: titleStyle.copyWith(
                                          color: Palette.pureWhite)),
                                  TextSpan(
                                      text: " 님",
                                      style: regularStyle.copyWith(
                                          color: Palette.pureWhite))
                                ],
                              ),
                            ),
                            CircleAvatar(
                              radius: 32,
                              backgroundImage: Image.asset(
                                      "assets/icons/user/profile_icon.png")
                                  .image,
                              backgroundColor: Colors.transparent,
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 16, right: 16, top: 8, bottom: 8),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            CircleButton(
                              imagePath:
                                  "assets/icons/main_icon_list/reading_room_icon.png",
                              text: "열람실",
                              onPressed: () {
                                launchUrlString(
                                    "https://libseat.dankook.ac.kr/mobile/PA/roomList.php?campus=J");
                              },
                            ),
                            CircleButton(
                              imagePath:
                                  "assets/icons/main_icon_list/web_info_icon.png",
                              text: "웹 정보",
                              onPressed: () {
                                launchUrlString(
                                    "https://webinfo.dankook.ac.kr/member/logon.do?sso=ok");
                              },
                            ),
                            CircleButton(
                              imagePath:
                                  "assets/icons/main_icon_list/school_schedule_icon.png",
                              text: "학사일정",
                              onPressed: () {
                                launchUrlString(
                                    "https://www.dankook.ac.kr/web/kor/-2014-");
                              },
                            ),
                            CircleButton(
                              imagePath:
                              "assets/icons/main_icon_list/school_food_icon.png",
                              text: "학식",
                              onPressed: () {
                                launchUrlString("https://www.dankook.ac.kr/web/kor/-556");
                              },
                            ),
                            CircleButton(
                              imagePath:
                                  "assets/icons/main_icon_list/students_council_icon.png",
                              text: "총학생회\nVOC",
                              onPressed: () {},
                            )
                          ],
                        ),
                      ),
                      Stack(
                        children: [
                          Positioned.fill(
                            child: Padding(
                              padding: const EdgeInsets.only(top: 32),
                              child: Container(
                                color: Palette.pureWhite,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                              left: 16,
                              right: 16,
                              bottom: 16,
                            ),
                            child: Column(
                              children: [
                                Obx(
                                  () => BoardList(
                                    cards: controller.isLoadBusList.value
                                        ? [
                                            Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceBetween,
                                              children: [
                                                Flexible(
                                                  flex: 1,
                                                  child: BusCard(
                                                    busNo: "24",
                                                    busColor: Palette.lightGreen,
                                                    station1: "곰상 출발",
                                                    predictTime1: controller
                                                                .findGomSangBusByNo(
                                                                    "24")
                                                                .predictTime1 !=
                                                            null
                                                        ? controller
                                                                        .findGomSangBusByNo(
                                                                            "24")
                                                                        .predictTime1! ~/
                                                                    60 ==
                                                                0
                                                            ? "곧 도착"
                                                            : "${controller.findGomSangBusByNo("24").predictTime1! ~/ 60}분 후"
                                                        : "정보 없음",
                                                    station2: "정문 출발",
                                                    predictTime2: controller
                                                                .findJungMoonBusByNo(
                                                                    "24")
                                                                .predictTime1 !=
                                                            null
                                                        ? controller.findJungMoonBusByNo(
                                                                            "24")
                                                                        .predictTime1! ~/
                                                                    60 ==
                                                                0
                                                            ? "곧 도착"
                                                            : "${controller.findJungMoonBusByNo("24").predictTime1! ~/ 60}분 후"
                                                        : "정보 없음",
                                                  ),
                                                ),
                                                Flexible(
                                                  flex: 1,
                                                  child: BusCard(
                                                    busNo: "8100",
                                                    busColor: Palette.lightRed,
                                                    station1: "정문 출발",
                                                    predictTime1: controller
                                                                .findJungMoonBusByNo(
                                                                    "8100")
                                                                .predictTime1 !=
                                                            null
                                                        ? controller
                                                                        .findJungMoonBusByNo(
                                                                            "8100")
                                                                        .predictTime1! ~/
                                                                    60 ==
                                                                0
                                                            ? "곧 도착"
                                                            : "${controller.findJungMoonBusByNo("8100").predictTime1! ~/ 60}분 후"
                                                        : "정보 없음",
                                                  ),
                                                ),
                                              ],
                                            ),
                                            Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceBetween,
                                              children: [
                                                Flexible(
                                                  flex: 1,
                                                  child: BusCard(
                                                    busNo: "720-3",
                                                    busColor: Palette.lightGreen,
                                                    station1: "곰상 출발",
                                                    predictTime1: controller
                                                                .findGomSangBusByNo(
                                                                    "720-3")
                                                                .predictTime1 !=
                                                            null
                                                        ? controller.findGomSangBusByNo(
                                                                            "720-3")
                                                                        .predictTime1! ~/
                                                                    60 ==
                                                                0
                                                            ? "곧 도착"
                                                            : "${controller.findGomSangBusByNo("720-3").predictTime1! ~/ 60}분 후"
                                                        : "정보 없음",
                                                    station2: "정문 출발",
                                                    predictTime2: controller
                                                                .findJungMoonBusByNo(
                                                                    "720-3")
                                                                .predictTime1 !=
                                                            null
                                                        ? controller.findJungMoonBusByNo(
                                                                            "720-3")
                                                                        .predictTime1! ~/
                                                                    60 ==
                                                                0
                                                            ? "곧 도착"
                                                            : "${controller.findJungMoonBusByNo("720-3").predictTime1! ~/ 60}분 후"
                                                        : "정보 없음",
                                                  ),
                                                ),
                                                Flexible(
                                                  flex: 1,
                                                  child: BusCard(
                                                    busNo: "1101",
                                                    busColor: Palette.lightRed,
                                                    station1: "정문 출발",
                                                    predictTime1: controller
                                                                .findJungMoonBusByNo(
                                                                    "1101")
                                                                .predictTime1 !=
                                                            null
                                                        ? controller.findJungMoonBusByNo(
                                                                            "1101")
                                                                        .predictTime1! ~/
                                                                    60 ==
                                                                0
                                                            ? "곧 도착"
                                                            : "${controller.findJungMoonBusByNo("1101").predictTime1! ~/ 60}분 후"
                                                        : "정보 없음",
                                                  ),
                                                ),
                                              ],
                                            ),
                                            Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceBetween,
                                              children: [
                                                Flexible(
                                                  flex: 1,
                                                  child: BusCard(
                                                    busNo: "셔틀",
                                                    busColor: Palette.lightBlue,
                                                    station1: "곰상 출발",
                                                    predictTime1: controller
                                                                .findGomSangBusByNo(
                                                                    "shuttle-bus")
                                                                .predictTime1 !=
                                                            null
                                                        ? controller.findGomSangBusByNo(
                                                                            "shuttle-bus")
                                                                        .predictTime1! ~/
                                                                    60 ==
                                                                0
                                                            ? "곧 도착"
                                                            : "${controller.findGomSangBusByNo("shuttle-bus").predictTime1! ~/ 60}분 후"
                                                        : "정보 없음",
                                                    station2: "정문 출발",
                                                    predictTime2: controller
                                                                .findJungMoonBusByNo(
                                                                    "shuttle-bus")
                                                                .predictTime1 !=
                                                            null
                                                        ? controller.findJungMoonBusByNo(
                                                                            "shuttle-bus")
                                                                        .predictTime1! ~/
                                                                    60 ==
                                                                0
                                                            ? "곧 도착"
                                                            : "${controller.findJungMoonBusByNo("shuttle-bus").predictTime1! ~/ 60}분 후"
                                                        : "정보 없음",
                                                  ),
                                                ),
                                                Flexible(
                                                  flex: 1,
                                                  child: BusCard(
                                                    busNo: "102",
                                                    busColor: Palette.lightRed,
                                                    station1: "정문 출발",
                                                    predictTime1: controller
                                                                .findJungMoonBusByNo(
                                                                    "102")
                                                                .predictTime1 !=
                                                            null
                                                        ? controller.findJungMoonBusByNo(
                                                                            "102")
                                                                        .predictTime1! ~/
                                                                    60 ==
                                                                0
                                                            ? "곧 도착"
                                                            : "${controller.findJungMoonBusByNo("102").predictTime1! ~/ 60}분 후"
                                                        : "정보 없음",
                                                  ),
                                                ),
                                              ],
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
                                    title: "버스 정보",
                                    showAction: false,
                                    actionTitle: "",
                                  ),
                                ),
                                Column(
                                  children: [
                                    //Banner
                                    const Padding(
                                      padding:
                                          EdgeInsets.only(bottom: 8, top: 16),
                                      child: BannerCard(
                                        title: '장애인 인권의 날 새로운 포토존 등장!',
                                        content: '지금 대면행사 보러가기',
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
                                          actionTitle: "더보기",
                                          onTapAction: () {
                                            final BoardPageController
                                                boardPageController =
                                                Get.find<BoardPageController>();
                                            final MainPageController
                                                mainController =
                                                Get.find<MainPageController>();
                                            mainController.selectedIndex.value = 2;
                                            boardPageController.selectedTap.value = 0;
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
                                          cards: controller.isLoadPetitionListHome.value
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
                                          actionTitle: "더보기",
                                          onTapAction: () {
                                            final BoardPageController
                                                boardPageController =
                                                Get.find<BoardPageController>();
                                            final MainPageController
                                                mainController =
                                                Get.find<MainPageController>();
                                            mainController.selectedIndex.value = 2;
                                            boardPageController.selectedTap.value = 1;
                                          },
                                        ),
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
