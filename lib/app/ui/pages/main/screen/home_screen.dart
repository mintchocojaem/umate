import 'package:danvery/app/controller/board_controller.dart';
import 'package:danvery/app/controller/login_controller.dart';
import 'package:danvery/app/controller/main_controller.dart';
import 'package:danvery/app/data/model/login_model.dart';
import 'package:danvery/app/ui/theme/app_text_theme.dart';
import 'package:danvery/app/ui/widgets/board/board_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher_string.dart';
import '../../../theme/app_colors.dart';
import '../../../widgets/board/board_list.dart';
import '../../../widgets/main/main_button.dart';

class HomeScreen extends GetView {
  const HomeScreen({Key? key}) : super(key: key);

  static List<BoardCard> busList = [
    BoardCard(
        leadingImage: Image.asset("assets/icons/bus_list/bus_24.png"),
        trailingText: "17분 후 도착",
        title: "단국대학교 정문 승차"),
    BoardCard(
        leadingImage: Image.asset("assets/icons/bus_list/bus_102.png"),
        trailingText: "2분 후 도착",
        title: "단국대학교 정문 승차"),
    BoardCard(
        leadingImage: Image.asset("assets/icons/bus_list/bus_720_3.png"),
        trailingText: "8분 후 도착",
        title: "단국대학교 정문 승차"),
    BoardCard(
        leadingImage: Image.asset("assets/icons/bus_list/bus_school.png"),
        trailingText: "20분 후 도착",
        title: "단국대학교 정문 승차"),
  ];

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

    final viewPadding = Get.mediaQuery.viewPadding;

    // TODO: implement build
    return Stack(
      children: [
        Container(
          height: viewPadding.top + 300,
          color: blue,
        ),
        SingleChildScrollView(
          child: Stack(
            children: [
              Column(
                children: [
                  Container(
                    width: double.infinity,
                    height: 300 + viewPadding.top,
                    color: blue,
                    child: Padding(
                      padding: const EdgeInsets.only(
                          right: 16, left: 16, top: 16, bottom: 8),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(height: viewPadding.top,),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                               Text.rich(
                                TextSpan(
                                  style: regularStyle.copyWith(color: white),
                                  text: '안녕하세요,\n', // default text style
                                  children: <TextSpan>[
                                    TextSpan(
                                        text:
                                            "${loginModel.major} ${loginModel.studentId.substring(2,4)}학번\n",
                                        style: titleStyle.copyWith(color: white)),
                                    TextSpan(
                                        text: loginModel.userName,
                                        style: titleStyle.copyWith(color: white)),
                                    TextSpan(
                                        text: " 님",
                                        style: regularStyle.copyWith(color: white))
                                  ],
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 20,
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
                                  launchUrlString("https://libseat.dankook.ac.kr/mobile/PA/roomList.php?campus=J");
                                },
                              ),
                              MainButton(
                                imagePath:
                                    "assets/icons/main_btn_list/web_info_btn.png",
                                text: "웹 정보",
                                onPressed: () {
                                  launchUrlString("https://webinfo.dankook.ac.kr/member/logon.do?sso=ok");
                                },
                              ),
                              MainButton(
                                imagePath:
                                    "assets/icons/main_btn_list/school_schedule_btn.png",
                                text: "학사일정",
                                onPressed: () {
                                  launchUrlString("https://www.dankook.ac.kr/web/kor/-2014-");
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
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.only(top: 300 + viewPadding.top),
                child: Container(color: white,height: Get.height - (300 + viewPadding.top),),
              ),
              Padding(
                padding:
                    const EdgeInsets.only(right: 16, left: 16, top: 8, bottom: 16),
                child: Column(
                  children: [
                    SizedBox(height: 200 + viewPadding.top,),
                    Padding(
                      padding: const EdgeInsets.only(top: 8, bottom: 8),
                      child: BoardList(
                          cards: busList, title: "버스 정보", actionTitle: "더보기"),
                    ),
                    //get suggestion board with Obx
                    Obx(() => boardController.isLoadGeneralBoard
                        ? Padding(
                            padding: const EdgeInsets.only(top: 8, bottom: 8),
                            child: BoardList(
                                cards: getBoardList(boardController.generalBoard),
                                title: "자유 게시판",
                                actionTitle: "더보기"),
                          )
                        : const SizedBox(
                            height: 200,
                            child: Center(child: CircularProgressIndicator()))),
                    //get petition board with Obx
                    Obx(() => boardController.isLoadPetitionBoard
                        ? Padding(
                            padding: const EdgeInsets.only(top: 8, bottom: 8),
                            child: BoardList(
                                cards: getBoardList(boardController.petitionBoard),
                                title: "청원게시판",
                                actionTitle: "더보기"),
                          )
                        : const SizedBox(
                            height: 200,
                            child: Center(child: CircularProgressIndicator()))),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
