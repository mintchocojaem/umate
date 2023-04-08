import 'dart:async';

import 'package:danvery/core/dto/api_response_dto.dart';
import 'package:danvery/domain/board/general_board/model/general_board_model.dart';
import 'package:danvery/domain/board/general_board/repository/general_board_repository.dart';
import 'package:danvery/domain/board/petition_board/model/petition_board_model.dart';
import 'package:danvery/domain/board/petition_board/repository/petition_board_repository.dart';
import 'package:danvery/domain/board/post/general_post/model/general_post_model.dart';
import 'package:danvery/domain/board/post/petition_post/model/petition_post_model.dart';
import 'package:danvery/domain/bus/model/bus_model.dart';
import 'package:danvery/domain/bus/repository/bus_repository.dart';
import 'package:danvery/service/login/login_service.dart';
import 'package:get/get.dart';

class HomePageController extends GetxController {
  final GeneralBoardRepository _generalBoardRepository =
      GeneralBoardRepository();
  final PetitionBoardRepository _petitionPostRepository =
      PetitionBoardRepository();
  final BusRepository _busRepository = BusRepository();

  final LoginService loginService = Get.find<LoginService>();

  final RxList<GeneralPostModel> generalPostListHome = <GeneralPostModel>[].obs;
  final RxBool isLoadGeneralPostListHome = false.obs;

  final RxList<PetitionPostModel> petitionListHome = <PetitionPostModel>[].obs;

  final RxBool isLoadPetitionListHome = false.obs;

  final RxList<BusModel> busListOfJungMoon = <BusModel>[].obs;
  final RxList<BusModel> busListOfGomSang = <BusModel>[].obs;

  final RxBool isLoadBusList = false.obs;

  @override
  void onInit() async {
    getBusList();
    Timer.periodic(const Duration(seconds: 30), (timer) {
      getBusList();
    });
    getGeneralPostListHome();
    getPetitionPostListHome();
    super.onInit();
  }

  Future<void> getGeneralPostListHome() async {
    final ApiResponseDTO apiResponseDTO = await _generalBoardRepository
        .getGeneralBoard(page: 0, size: 5, keyword: '');
    if (apiResponseDTO.success) {
      final GeneralBoardModel generalBoardModel = apiResponseDTO.data
          as GeneralBoardModel;
      generalPostListHome.value = generalBoardModel.generalPosts;
      isLoadGeneralPostListHome.value = true;
    }
  }

  Future<void> getPetitionPostListHome() async {
    final ApiResponseDTO apiResponseDTO = await _petitionPostRepository
        .getPetitionBoard(page: 0, size: 5, status: "ACTIVE");
    if (apiResponseDTO.success) {
      final PetitionBoardModel petitionBoardModel = apiResponseDTO.data
          as PetitionBoardModel;
      petitionListHome.value = petitionBoardModel.petitionPosts;
      isLoadPetitionListHome.value = true;
    }
  }

  Future<void> getBusList() async {
    final ApiResponseDTO apiResponseDTO1 =
        await _busRepository.getBusListFromStation(stationName: "단국대정문");
    final ApiResponseDTO apiResponseDTO2 = await _busRepository
        .getBusListFromStation(stationName: "곰상");

    if (apiResponseDTO1.success && apiResponseDTO2.success) {
      final List<BusModel> busList1 = apiResponseDTO1.data as List<BusModel>;
      busListOfJungMoon.value = busList1;

      final List<BusModel> busList2 = apiResponseDTO2.data as List<BusModel>;
      busListOfGomSang.value = busList2;
    }

    if (busListOfJungMoon.isNotEmpty && busListOfGomSang.isNotEmpty) {
      isLoadBusList.value = true;
    }
  }

  BusModel findJungMoonBusByNo(String no) {
    return busListOfJungMoon.firstWhere((p0) => p0.busNo == no);
  }

  BusModel findGomSangBusByNo(String no) {
    return busListOfGomSang.firstWhere((p0) => p0.busNo == no);
  }
}
