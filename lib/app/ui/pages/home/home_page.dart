import 'package:danvery/app/controller/board_controller.dart';
import 'package:danvery/app/controller/board_page_controller.dart';
import 'package:danvery/app/controller/bus_controller.dart';
import 'package:danvery/app/controller/login_controller.dart';
import 'package:danvery/app/controller/main_controller.dart';
import 'package:danvery/app/data/model/login_model.dart';
import 'package:danvery/app/ui/theme/app_text_theme.dart';
import 'package:danvery/app/ui/theme/palette.dart';
import 'package:danvery/app/ui/widgets/app_bar/main_app_bar.dart';
import 'package:danvery/app/ui/widgets/board/board_card.dart';
import 'package:danvery/app/ui/widgets/main/banner_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher_string.dart';
import '../../../../routes/app_routes.dart';
import '../../widgets/board/board_list.dart';
import '../../widgets/main/main_button.dart';

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
    final BoardController boardController = Get.find<BoardController>();
    final LoginModel loginModel = Get.find<LoginController>().loginModel;

    final BusController busController = Get.find<BusController>();

    busController.refreshBusList();

    // TODO: implement build
    return Scaffold(
      appBar: MainAppBar(
        title: "Danvery",
        titleColor: Palette.pureWhite,
        backGroundColor: Palette.blue,
        isWhite: true,
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
                Padding(
                  padding: const EdgeInsets.only(
                      right: 16, left: 16, top: 16, bottom: 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
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
                      const SizedBox(
                        height: 8,
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          MainButton(
                            imagePath:
                                "assets/icons/main_btn_list/school_home_btn.png",
                            text: "학교 홈",
                            onPressed: () {
                              launchUrlString("https://www.dankook.ac.kr/web");
                            },
                          ),
                          MainButton(
                            imagePath:
                                "assets/icons/main_btn_list/reading_room_btn.png",
                            text: "열람실",
                            onPressed: () {
                              launchUrlString(
                                  "https://libseat.dankook.ac.kr/mobile/PA/roomList.php?campus=J");
                            },
                          ),
                          MainButton(
                            imagePath:
                                "assets/icons/main_btn_list/web_info_btn.png",
                            text: "웹 정보",
                            onPressed: () {
                              launchUrlString(
                                  "https://webinfo.dankook.ac.kr/member/logon.do?sso=ok");
                            },
                          ),
                          MainButton(
                            imagePath:
                                "assets/icons/main_btn_list/school_schedule_btn.png",
                            text: "학사일정",
                            onPressed: () {
                              launchUrlString(
                                  "https://www.dankook.ac.kr/web/kor/-2014-");
                            },
                          ),
                          MainButton(
                            imagePath:
                                "assets/icons/main_btn_list/students_council_btn.png",
                            text: "총학생회\nVOC",
                            onPressed: () {},
                          )
                        ],
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 200),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Palette.pureWhite,
                      borderRadius: const BorderRadius.only(
                          topRight: Radius.circular(10),
                          topLeft: Radius.circular(10)),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(
                          left: 16, right: 16, top: 16, bottom: 16),
                      child: Column(
                        children: [
                          const Padding(
                            padding: EdgeInsets.only(bottom: 8),
                            child: BannerCard(
                              title: '장애인 인권의 날 새로운 포토존 등장!',
                              content: '지금 대면행사 보러가기',
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 8, bottom: 8),
                            child: Obx(
                              () => BoardList(
                                cards: busController.isLoadBusList
                                    ? [
                                        BoardCard(
                                            leadingImage: Image.asset(
                                                "assets/icons/bus_list/bus_24.png"),
                                            trailingText: busController
                                                        .findJungMoonBusByNo(
                                                            "24")
                                                        .predictTime1 !=
                                                    null
                                                ? "${busController.findJungMoonBusByNo("24").predictTime1! ~/ 60}분 후 출발 예정"
                                                : "도착정보 없음",
                                            title: "단국대학교 정문 승차"),
                                        BoardCard(
                                            leadingImage: Image.asset(
                                                "assets/icons/bus_list/bus_102.png"),
                                            trailingText: busController
                                                        .findJungMoonBusByNo(
                                                            "102")
                                                        .predictTime1 !=
                                                    null
                                                ? "${busController.findJungMoonBusByNo("102").predictTime1! ~/ 60}분 후 출발 예정"
                                                : "도착정보 없음",
                                            title: "단국대학교 정문 승차"),
                                        BoardCard(
                                            leadingImage: Image.asset(
                                                "assets/icons/bus_list/bus_720_3.png"),
                                            trailingText: busController
                                                        .findJungMoonBusByNo(
                                                            "720-3")
                                                        .predictTime1 !=
                                                    null
                                                ? "${busController.findJungMoonBusByNo("720-3").predictTime1! ~/ 60}분 후 출발 예정"
                                                : "도착정보 없음",
                                            title: "단국대학교 정문 승차"),
                                        BoardCard(
                                            leadingImage: Image.asset(
                                                "assets/icons/bus_list/bus_school.png"),
                                            trailingText: busController
                                                        .findJungMoonBusByNo(
                                                            "shuttle-bus")
                                                        .predictTime1 !=
                                                    null
                                                ? "${busController.findJungMoonBusByNo("shuttle-bus").predictTime1! ~/ 60}분 후 출발 예정"
                                                : "도착정보 없음",
                                            title: "단국대학교 정문 승차"),
                                      ]
                                    : [
                                        const SizedBox(
                                          height: 200,
                                          child: Center(
                                            child: CircularProgressIndicator(),
                                          ),
                                        ),
                                      ],
                                title: "버스 정보",
                                showAction: false,
                                actionTitle: "",
                              ),
                            ),
                          ),
                          //get suggestion board with Obx
                          Obx(() => boardController.isLoadGeneralBoard
                              ? Padding(
                                  padding:
                                      const EdgeInsets.only(top: 8, bottom: 8),
                                  child: BoardList(
                                    cards: getBoardList(
                                        boardController.generalBoard),
                                    title: "자유 게시판",
                                    actionTitle: "더보기",
                                    onTapAction: () {
                                      final BoardPageController
                                          boardPageController =
                                          Get.find<BoardPageController>();
                                      final MainController mainController =
                                          Get.find<MainController>();
                                      mainController.selectedIndex = 2;
                                      boardPageController.selectedTap = 0;
                                    },
                                  ),
                                )
                              : const SizedBox(
                                  height: 200,
                                  child: Center(
                                      child: CircularProgressIndicator()))),
                          //get petition board with Obx
                          Obx(() => boardController.isLoadPetitionBoard
                              ? Padding(
                                  padding:
                                      const EdgeInsets.only(top: 8, bottom: 8),
                                  child: BoardList(
                                    cards: getBoardList(
                                        boardController.petitionBoard),
                                    title: "청원게시판",
                                    actionTitle: "더보기",
                                    onTapAction: () {
                                      final BoardPageController
                                          boardPageController =
                                          Get.find<BoardPageController>();
                                      final MainController mainController =
                                          Get.find<MainController>();
                                      mainController.selectedIndex = 2;
                                      boardPageController.selectedTap = 1;
                                    },
                                  ),
                                )
                              : const SizedBox(
                                  height: 200,
                                  child: Center(
                                      child: CircularProgressIndicator()))),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
