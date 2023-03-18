
import 'package:danvery/domain/auth/login/model/login_model.dart';
import 'package:danvery/domain/auth/login/services/login_service.dart';
import 'package:danvery/utils/theme/app_text_theme.dart';
import 'package:danvery/utils/theme/palette.dart';
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

import '../../../../../domain/board/petition/controller/petition_controller.dart';
import '../../../../../domain/board/petition/controller/post_controller.dart';
import '../../../../../domain/bus/controller/bus_controller.dart';
import '../../main_page/controller/main_page_controller.dart';



class HomePage extends GetView {
  const HomePage({Key? key}) : super(key: key);

  List<BoardCard> getBoardList(dynamic data) {
    List<BoardCard> result = [];
    for (dynamic i in data) {
      result.add(BoardCard(leadingText: "익명", title: i.title));
    }
    return result;
  }

  @override
  Widget build(BuildContext context) {
    final PostController postController = Get.find<PostController>();
    final PetitionController petitionController = Get.find<PetitionController>();
    final LoginModel loginModel = Get.find<LoginService>().loginModel;

    final BusController busController = Get.find<BusController>();

    // TODO: implement build
    return Scaffold(
      appBar: MainAppBar(
        titleColor: Palette.pureWhite,
        backGroundColor: Palette.blue,
        isWhite: true,
        isDarkMode: !Get.isDarkMode,
      ),
      body: Stack(
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
                                        "${loginModel.major} ${loginModel.studentId.substring(2, 4)}학번\n",
                                    style: titleStyle.copyWith(
                                        color: Palette.pureWhite)),
                                TextSpan(
                                    text: loginModel.userName,
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
                                "assets/icons/main_btn_list/school_home_btn.png",
                            text: "학교 홈",
                            onPressed: () {
                              launchUrlString("https://www.dankook.ac.kr/web");
                            },
                          ),
                          CircleButton(
                            imagePath:
                                "assets/icons/main_btn_list/reading_room_btn.png",
                            text: "열람실",
                            onPressed: () {
                              launchUrlString(
                                  "https://libseat.dankook.ac.kr/mobile/PA/roomList.php?campus=J");
                            },
                          ),
                          CircleButton(
                            imagePath:
                                "assets/icons/main_btn_list/web_info_btn.png",
                            text: "웹 정보",
                            onPressed: () {
                              launchUrlString(
                                  "https://webinfo.dankook.ac.kr/member/logon.do?sso=ok");
                            },
                          ),
                          CircleButton(
                            imagePath:
                                "assets/icons/main_btn_list/school_schedule_btn.png",
                            text: "학사일정",
                            onPressed: () {
                              launchUrlString(
                                  "https://www.dankook.ac.kr/web/kor/-2014-");
                            },
                          ),
                          CircleButton(
                            imagePath:
                                "assets/icons/main_btn_list/students_council_btn.png",
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
                                  cards: busController.isLoadBusList
                                      ? [
                                          Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              BusCard(
                                                busNo: "24",
                                                busColor: Palette.lightGreen,
                                                station1: "곰상 출발",
                                                predictTime1: busController
                                                            .findGomSangBusByNo(
                                                                "24")
                                                            .predictTime1 !=
                                                        null
                                                    ? busController
                                                                    .findGomSangBusByNo(
                                                                        "24")
                                                                    .predictTime1! ~/
                                                                60 ==
                                                            0
                                                        ? "곧 도착"
                                                        : "${busController.findGomSangBusByNo("24").predictTime1! ~/ 60}분 후"
                                                    : "정보 없음",
                                                station2: "정문 출발",
                                                predictTime2: busController
                                                            .findJungMoonBusByNo(
                                                                "24")
                                                            .predictTime1 !=
                                                        null
                                                    ? busController
                                                                    .findJungMoonBusByNo(
                                                                        "24")
                                                                    .predictTime1! ~/
                                                                60 ==
                                                            0
                                                        ? "곧 도착"
                                                        : "${busController.findJungMoonBusByNo("24").predictTime1! ~/ 60}분 후"
                                                    : "정보 없음",
                                              ),
                                              BusCard(
                                                busNo: "8100",
                                                busColor: Palette.lightRed,
                                                station1: "정문 출발",
                                                predictTime1: busController
                                                            .findJungMoonBusByNo(
                                                                "8100")
                                                            .predictTime1 !=
                                                        null
                                                    ? busController
                                                                    .findJungMoonBusByNo(
                                                                        "8100")
                                                                    .predictTime1! ~/
                                                                60 ==
                                                            0
                                                        ? "곧 도착"
                                                        : "${busController.findJungMoonBusByNo("8100").predictTime1! ~/ 60}분 후"
                                                    : "정보 없음",
                                              ),
                                            ],
                                          ),
                                          Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              BusCard(
                                                busNo: "720-3",
                                                busColor: Palette.lightGreen,
                                                station1: "곰상 출발",
                                                predictTime1: busController
                                                            .findGomSangBusByNo(
                                                                "720-3")
                                                            .predictTime1 !=
                                                        null
                                                    ? busController
                                                                    .findGomSangBusByNo(
                                                                        "720-3")
                                                                    .predictTime1! ~/
                                                                60 ==
                                                            0
                                                        ? "곧 도착"
                                                        : "${busController.findGomSangBusByNo("720-3").predictTime1! ~/ 60}분 후"
                                                    : "정보 없음",
                                                station2: "정문 출발",
                                                predictTime2: busController
                                                            .findJungMoonBusByNo(
                                                                "720-3")
                                                            .predictTime1 !=
                                                        null
                                                    ? busController
                                                                    .findJungMoonBusByNo(
                                                                        "720-3")
                                                                    .predictTime1! ~/
                                                                60 ==
                                                            0
                                                        ? "곧 도착"
                                                        : "${busController.findJungMoonBusByNo("720-3").predictTime1! ~/ 60}분 후"
                                                    : "정보 없음",
                                              ),
                                              BusCard(
                                                busNo: "1101",
                                                busColor: Palette.lightRed,
                                                station1: "정문 출발",
                                                predictTime1: busController
                                                            .findJungMoonBusByNo(
                                                                "1101")
                                                            .predictTime1 !=
                                                        null
                                                    ? busController
                                                                    .findJungMoonBusByNo(
                                                                        "1101")
                                                                    .predictTime1! ~/
                                                                60 ==
                                                            0
                                                        ? "곧 도착"
                                                        : "${busController.findJungMoonBusByNo("1101").predictTime1! ~/ 60}분 후"
                                                    : "정보 없음",
                                              ),
                                            ],
                                          ),
                                          Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              BusCard(
                                                busNo: "셔틀",
                                                busColor: Palette.lightBlue,
                                                station1: "곰상 출발",
                                                predictTime1: busController
                                                            .findGomSangBusByNo(
                                                                "shuttle-bus")
                                                            .predictTime1 !=
                                                        null
                                                    ? busController
                                                                    .findGomSangBusByNo(
                                                                        "shuttle-bus")
                                                                    .predictTime1! ~/
                                                                60 ==
                                                            0
                                                        ? "곧 도착"
                                                        : "${busController.findGomSangBusByNo("shuttle-bus").predictTime1! ~/ 60}분 후"
                                                    : "정보 없음",
                                                station2: "정문 출발",
                                                predictTime2: busController
                                                            .findJungMoonBusByNo(
                                                                "shuttle-bus")
                                                            .predictTime1 !=
                                                        null
                                                    ? busController
                                                                    .findJungMoonBusByNo(
                                                                        "shuttle-bus")
                                                                    .predictTime1! ~/
                                                                60 ==
                                                            0
                                                        ? "곧 도착"
                                                        : "${busController.findJungMoonBusByNo("shuttle-bus").predictTime1! ~/ 60}분 후"
                                                    : "정보 없음",
                                              ),
                                              BusCard(
                                                busNo: "102",
                                                busColor: Palette.lightRed,
                                                station1: "정문 출발",
                                                predictTime1: busController
                                                            .findJungMoonBusByNo(
                                                                "102")
                                                            .predictTime1 !=
                                                        null
                                                    ? busController
                                                                    .findJungMoonBusByNo(
                                                                        "102")
                                                                    .predictTime1! ~/
                                                                60 ==
                                                            0
                                                        ? "곧 도착"
                                                        : "${busController.findJungMoonBusByNo("102").predictTime1! ~/ 60}분 후"
                                                    : "정보 없음",
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
                                  Obx(() => postController.isLoadGeneralBoard
                                      ? Padding(
                                          padding: const EdgeInsets.only(
                                              top: 8, bottom: 8),
                                          child: BoardList(
                                            cards: getBoardList(
                                                postController.generalBoard),
                                            title: "자유 게시판",
                                            actionTitle: "더보기",
                                            onTapAction: () {
                                              final BoardPageController
                                                  boardPageController =
                                                  Get.find<
                                                      BoardPageController>();
                                              final MainPageController
                                                  mainController =
                                                  Get.find<MainPageController>();
                                              mainController.selectedIndex = 2;
                                              boardPageController.selectedTap =
                                                  0;
                                            },
                                          ),
                                        )
                                      : const SizedBox(
                                          height: 200,
                                          child: Center(
                                              child:
                                                  CircularProgressIndicator()))),
                                  //get petition board with Obx
                                  Obx(() => petitionController.isLoadPetitionBoard
                                      ? Padding(
                                          padding: const EdgeInsets.only(
                                              top: 8, bottom: 8),
                                          child: BoardList(
                                            cards: getBoardList(
                                                petitionController.petitionBoard),
                                            title: "청원게시판",
                                            actionTitle: "더보기",
                                            onTapAction: () {
                                              final BoardPageController
                                                  boardPageController =
                                                  Get.find<
                                                      BoardPageController>();
                                              final MainPageController
                                                  mainController =
                                                  Get.find<MainPageController>();
                                              mainController.selectedIndex = 2;
                                              boardPageController.selectedTap =
                                                  1;
                                            },
                                          ),
                                        )
                                      : const SizedBox(
                                          height: 200,
                                          child: Center(
                                              child:
                                                  CircularProgressIndicator()))),
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
    );
  }
}
