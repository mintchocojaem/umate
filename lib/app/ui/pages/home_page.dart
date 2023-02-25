import 'package:danvery/app/controller/home_controller.dart';
import 'package:danvery/app/ui/theme/app_text_theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../main.dart';
import '../../data/dto/board_list_dto.dart';
import '../theme/app_colors.dart';
import '../widgets/board_list.dart';
import '../widgets/main_button.dart';

class HomePage extends GetView<HomeController> {
  const HomePage({Key? key}) : super(key: key);

  static List<BoardListDTO> busList = [
    BoardListDTO(
        leadingImagePath: "assets/icons/bus_list/bus_24.png",
        trailingText: "17분 후 도착",
        title: "단국대학교 정문 승차"),
    BoardListDTO(
        leadingImagePath: "assets/icons/bus_list/bus_102.png",
        trailingText: "2분 후 도착",
        title: "단국대학교 정문 승차"),
    BoardListDTO(
        leadingImagePath: "assets/icons/bus_list/bus_720_3.png",
        trailingText: "8분 후 도착",
        title: "단국대학교 정문 승차"),
    BoardListDTO(
        leadingImagePath: "assets/icons/bus_list/bus_school.png",
        trailingText: "20분 후 도착",
        title: "단국대학교 정문 승차"),
  ];

  List<BoardListDTO> getBoardList(dynamic data) {
    List<BoardListDTO> result = [];
    for (dynamic i in data) {
      result.add(BoardListDTO(leadingText: "익명", title: i.title));
    }
    return result;
  }

  @override
  Widget build(BuildContext context) {
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
                                        "${userModel.major} ${userModel.studentNumber.substring(2, 4)}학번\n",
                                    style: titleStyle.copyWith(color: white)),
                                TextSpan(
                                    text: userModel.name,
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
                      data: busList, title: "버스 정보", actionTitle: "더보기"),
                ),
                //get suggestion board with Obx
                Obx(() => controller.suggestionBoard.isNotEmpty
                    ? Padding(
                        padding: const EdgeInsets.only(top: 8, bottom: 8),
                        child: BoardList(
                            data: getBoardList(controller.suggestionBoard),
                            title: "자유 게시판",
                            actionTitle: "더보기"),
                      )
                    : const SizedBox(
                        height: 200,
                        child: Center(child: CircularProgressIndicator()))),
                //get petition board with Obx
                Obx(() => controller.petitionBoard.isNotEmpty
                    ? Padding(
                        padding: const EdgeInsets.only(top: 8, bottom: 8),
                        child: BoardList(
                            data: getBoardList(controller.petitionBoard),
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
