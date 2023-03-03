import 'package:danvery/app/controller/home_controller.dart';
import 'package:danvery/app/controller/login_controller.dart';
import 'package:danvery/app/data/model/login_model.dart';
import 'package:danvery/app/ui/theme/app_text_theme.dart';
import 'package:danvery/app/ui/widgets/board/board_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../main.dart';
import '../../../controller/home_controller.dart';
import '../../theme/app_colors.dart';
import '../../widgets/board/board_list.dart';
import '../../widgets/button/main_button.dart';

class HomePage extends GetView {
  const HomePage({Key? key}) : super(key: key);

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

    final HomeController homeController = Get.find<HomeController>();
    final LoginModel loginModel = Get.find<LoginController>().loginModel;

    // TODO: implement build
    return SingleChildScrollView(
      child: Stack(
        children: [
          Column(
            children: [
              Container(
                width: double.infinity,
                height: 300,
                color: blue,
                child: Padding(
                  padding: const EdgeInsets.only(
                      right: 16, left: 16, top: 16, bottom: 8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
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
                            onPressed: () {},
                          ),
                          MainButton(
                            imagePath:
                                "assets/icons/main_btn_list/reading_room_btn.png",
                            text: "열람실",
                            onPressed: () {},
                          ),
                          MainButton(
                            imagePath:
                                "assets/icons/main_btn_list/web_info_btn.png",
                            text: "웹 정보",
                            onPressed: () {},
                          ),
                          MainButton(
                            imagePath:
                                "assets/icons/main_btn_list/school_schedule_btn.png",
                            text: "학사일정",
                            onPressed: () {},
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
            padding:
                const EdgeInsets.only(right: 16, left: 16, top: 8, bottom: 16),
            child: Column(
              children: [
                const SizedBox(height: 200),
                Padding(
                  padding: const EdgeInsets.only(top: 8, bottom: 8),
                  child: BoardList(
                      cards: busList, title: "버스 정보", actionTitle: "더보기"),
                ),
                //get suggestion board with Obx
                Obx(() => homeController.isLoadGeneralBoard
                    ? Padding(
                        padding: const EdgeInsets.only(top: 8, bottom: 8),
                        child: BoardList(
                            cards: getBoardList(homeController.generalBoard),
                            title: "자유 게시판",
                            actionTitle: "더보기"),
                      )
                    : const SizedBox(
                        height: 200,
                        child: Center(child: CircularProgressIndicator()))),
                //get petition board with Obx
                Obx(() => homeController.isLoadPetitionBoard
                    ? Padding(
                        padding: const EdgeInsets.only(top: 8, bottom: 8),
                        child: BoardList(
                            cards: getBoardList(homeController.petitionBoard),
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
    );
  }
}
