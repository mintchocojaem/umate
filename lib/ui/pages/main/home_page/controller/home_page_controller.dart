import 'dart:async';

import 'package:danvery/core/dto/api_response_dto.dart';
import 'package:danvery/core/theme/palette.dart';
import 'package:danvery/domain/banner/model/banner_list_model.dart';
import 'package:danvery/domain/banner/model/banner_model.dart';
import 'package:danvery/domain/banner/repository/banner_repository.dart';
import 'package:danvery/domain/board/general_board/model/general_board_model.dart';
import 'package:danvery/domain/board/general_board/repository/general_board_repository.dart';
import 'package:danvery/domain/board/petition_board/model/petition_board_model.dart';
import 'package:danvery/domain/board/petition_board/repository/petition_board_repository.dart';
import 'package:danvery/domain/board/post/general_post/model/general_post_model.dart';
import 'package:danvery/domain/board/post/petition_post/model/petition_post_model.dart';
import 'package:danvery/domain/bus/model/bus_model.dart';
import 'package:danvery/domain/bus/repository/bus_repository.dart';
import 'package:danvery/service/login/login_service.dart';
import 'package:danvery/ui/pages/main/board/board_page/controller/board_page_controller.dart';
import 'package:danvery/ui/pages/main/main_page/controller/main_page_controller.dart';
import 'package:danvery/ui/widgets/board/bus_card.dart';
import 'package:danvery/ui/widgets/circle_button/circle_button.dart';
import 'package:danvery/ui/widgets/getx_snackbar/getx_snackbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher_string.dart';

class HomePageController extends GetxController {
  final GeneralBoardRepository _generalBoardRepository =
      GeneralBoardRepository();
  final PetitionBoardRepository _petitionPostRepository =
      PetitionBoardRepository();
  final BusRepository _busRepository = BusRepository();
  final BannerRepository bannerRepository = BannerRepository();

  final LoginService loginService = Get.find<LoginService>();

  final MainPageController mainPageController = Get.find<MainPageController>();
  final BoardPageController boardPageController =
      Get.find<BoardPageController>();

  final Rx<BannerListModel> bannerList = BannerListModel(
    bannerList: <BannerModel>[],
    subBannerList: [],
  ).obs;

  final RxList<GeneralPostModel> generalPostListHome = <GeneralPostModel>[].obs;
  final RxBool isLoadGeneralPostListHome = false.obs;

  final RxList<PetitionPostModel> petitionListHome = <PetitionPostModel>[].obs;

  final RxBool isLoadPetitionListHome = false.obs;

  final RxList<BusModel> busListOfJungMoon = <BusModel>[].obs;
  final RxList<BusModel> busListOfGomSang = <BusModel>[].obs;

  final RxBool isLoadBusList = false.obs;

  final RxBool isLoadBannerList = false.obs;

  final RxInt currentBannerIndex = 0.obs;

  late List<Widget> busCards;

  final List<Widget> mainButtons = [
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
        launchUrlString(
            "https://www.dankook.ac.kr/web/kor/-556");
      },
    ),
    CircleButton(
      imagePath:
      "assets/icons/main_icon_list/students_council_icon.png",
      text: "총학생회\nVOC",
      onPressed: () {},
    )
  ];

  final ScrollController scrollController = ScrollController();
  final RxDouble currentScrollPosition = 0.0.obs;

  @override
  void onInit() async{
    await getBusList();
    await getGeneralPostListHome();
    await getPetitionPostListHome();
    await getBannerList();
    Timer.periodic(const Duration(seconds: 60), (timer) async{
      await getBusList();
      await getGeneralPostListHome();
      await getPetitionPostListHome();
      await getBannerList();
    });

    Timer.periodic(const Duration(seconds: 10), (timer) {
      currentBannerIndex.value = currentBannerIndex.value + 1;
      if(currentBannerIndex.value >= bannerList.value.bannerList.length){
        currentBannerIndex.value = 0;
      }
    });

    scrollController.addListener(() {
      if(scrollController.offset / scrollController.position.maxScrollExtent > 1){
        currentScrollPosition.value = 1.0;
      }else if(scrollController.offset / scrollController.position.maxScrollExtent < 0){
        currentScrollPosition.value = 0.0;
      }else{
        currentScrollPosition.value = scrollController.offset / scrollController.position.maxScrollExtent;
      }
    });

    super.onInit();
  }

  Future<void> getGeneralPostListHome() async {
    final ApiResponseDTO apiResponseDTO = await _generalBoardRepository
        .getGeneralBoard(page: 0, size: 5, keyword: '');
    if (apiResponseDTO.success) {
      final GeneralBoardModel generalBoardModel =
          apiResponseDTO.data as GeneralBoardModel;
      generalPostListHome.value = generalBoardModel.generalPosts;
      isLoadGeneralPostListHome.value = true;
    }
  }

  Future<void> getPetitionPostListHome() async {
    final ApiResponseDTO apiResponseDTO = await _petitionPostRepository
        .getPetitionBoard(page: 0, size: 5, status: "ACTIVE", keyword: '');
    if (apiResponseDTO.success) {
      final PetitionBoardModel petitionBoardModel =
          apiResponseDTO.data as PetitionBoardModel;
      petitionListHome.value = petitionBoardModel.petitionPosts;
      isLoadPetitionListHome.value = true;
    }
  }

  Future<void> getBusList() async {
    final ApiResponseDTO apiResponseDTO1 =
        await _busRepository.getBusListFromStation(stationName: "단국대정문");
    final ApiResponseDTO apiResponseDTO2 =
        await _busRepository.getBusListFromStation(stationName: "곰상");

    if (apiResponseDTO1.success && apiResponseDTO2.success) {
      final List<BusModel> busList1 = apiResponseDTO1.data as List<BusModel>;
      busListOfJungMoon.value = busList1;

      final List<BusModel> busList2 = apiResponseDTO2.data as List<BusModel>;
      busListOfGomSang.value = busList2;
    }

    if (busListOfJungMoon.isNotEmpty && busListOfGomSang.isNotEmpty) {
      busCards = [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Flexible(
              flex: 1,
              child: BusCard(
                busNo: "24",
                busColor: Palette.lightGreen,
                station1: "곰상 출발",
                predictTime1: findGomSangBusByNo("24").predictTime1 != null
                    ? findGomSangBusByNo("24").predictTime1! ~/ 60 == 0
                        ? "곧 도착"
                        : "${findGomSangBusByNo("24").predictTime1! ~/ 60}분 후"
                    : "정보 없음",
                station2: "정문 출발",
                predictTime2: findJungMoonBusByNo("24").predictTime1 != null
                    ? findJungMoonBusByNo("24").predictTime1! ~/ 60 == 0
                        ? "곧 도착"
                        : "${findJungMoonBusByNo("24").predictTime1! ~/ 60}분 후"
                    : "정보 없음",
              ),
            ),
            Flexible(
              flex: 1,
              child: BusCard(
                busNo: "8100",
                busColor: Palette.lightRed,
                station1: "정문 출발",
                predictTime1: findJungMoonBusByNo("8100").predictTime1 != null
                    ? findJungMoonBusByNo("8100").predictTime1! ~/ 60 == 0
                        ? "곧 도착"
                        : "${findJungMoonBusByNo("8100").predictTime1! ~/ 60}분 후"
                    : "정보 없음",
              ),
            ),
          ],
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Flexible(
              flex: 1,
              child: BusCard(
                busNo: "720-3",
                busColor: Palette.lightGreen,
                station1: "곰상 출발",
                predictTime1: findGomSangBusByNo("720-3").predictTime1 != null
                    ? findGomSangBusByNo("720-3").predictTime1! ~/ 60 == 0
                        ? "곧 도착"
                        : "${findGomSangBusByNo("720-3").predictTime1! ~/ 60}분 후"
                    : "정보 없음",
                station2: "정문 출발",
                predictTime2: findJungMoonBusByNo("720-3").predictTime1 != null
                    ? findJungMoonBusByNo("720-3").predictTime1! ~/ 60 == 0
                        ? "곧 도착"
                        : "${findJungMoonBusByNo("720-3").predictTime1! ~/ 60}분 후"
                    : "정보 없음",
              ),
            ),
            Flexible(
              flex: 1,
              child: BusCard(
                busNo: "1101",
                busColor: Palette.lightRed,
                station1: "정문 출발",
                predictTime1: findJungMoonBusByNo("1101").predictTime1 != null
                    ? findJungMoonBusByNo("1101").predictTime1! ~/ 60 == 0
                        ? "곧 도착"
                        : "${findJungMoonBusByNo("1101").predictTime1! ~/ 60}분 후"
                    : "정보 없음",
              ),
            ),
          ],
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Flexible(
              flex: 1,
              child: BusCard(
                busNo: "셔틀",
                busColor: Palette.lightBlue,
                station1: "곰상 출발",
                predictTime1: findGomSangBusByNo("shuttle-bus").predictTime1 !=
                        null
                    ? findGomSangBusByNo("shuttle-bus").predictTime1! ~/ 60 == 0
                        ? "곧 도착"
                        : "${findGomSangBusByNo("shuttle-bus").predictTime1! ~/ 60}분 후"
                    : "정보 없음",
                station2: "정문 출발",
                predictTime2: findJungMoonBusByNo("shuttle-bus").predictTime1 !=
                        null
                    ? findJungMoonBusByNo("shuttle-bus").predictTime1! ~/ 60 ==
                            0
                        ? "곧 도착"
                        : "${findJungMoonBusByNo("shuttle-bus").predictTime1! ~/ 60}분 후"
                    : "정보 없음",
              ),
            ),
            Flexible(
              flex: 1,
              child: BusCard(
                busNo: "102",
                busColor: Palette.lightRed,
                station1: "정문 출발",
                predictTime1: findJungMoonBusByNo("102").predictTime1 != null
                    ? findJungMoonBusByNo("102").predictTime1! ~/ 60 == 0
                        ? "곧 도착"
                        : "${findJungMoonBusByNo("102").predictTime1! ~/ 60}분 후"
                    : "정보 없음",
              ),
            ),
          ],
        ),
      ];
      isLoadBusList.value = true;
    }
  }

  BusModel findJungMoonBusByNo(String no) {
    return busListOfJungMoon.firstWhere((p0) => p0.busNo == no);
  }

  BusModel findGomSangBusByNo(String no) {
    return busListOfGomSang.firstWhere((p0) => p0.busNo == no);
  }

  Future<void> getBannerList() async{
    final ApiResponseDTO apiResponseDTO = await bannerRepository.getBannerList();
    if (apiResponseDTO.success) {
      bannerList.value = apiResponseDTO.data as BannerListModel;
      isLoadBannerList.value = true;
    }else{
      GetXSnackBar(
        type: GetXSnackBarType.customError,
        title: "배너 목록 조회 실패",
        content: apiResponseDTO.message,
      ).show();
    }
  }

}
