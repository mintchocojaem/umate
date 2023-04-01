import 'package:danvery/domain/board/general_board/repository/general_board_repository.dart';
import 'package:danvery/domain/board/petition_board/repository/petition_board_repository.dart';
import 'package:danvery/domain/board/post/general_post/model/general_post_model.dart';
import 'package:danvery/domain/board/post/petition_post/model/petition_post_model.dart';
import 'package:danvery/domain/bus/model/bus_model.dart';
import 'package:danvery/domain/bus/repository/bus_repository.dart';
import 'package:danvery/service/login/login_service.dart';
import 'package:get/get.dart';

class HomePageController extends GetxController {

  final GeneralBoardRepository _generalBoardRepository = GeneralBoardRepository();
  final PetitionBoardRepository _petitionPostRepository = PetitionBoardRepository();
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
  void onInit() async{

    getBusList();
    getGeneralPostListHome();
    getPetitionPostListHome();
    super.onInit();
  }

  Future<void> getGeneralPostListHome() async {
    await _generalBoardRepository
        .getGeneralBoard(page: 0, size: 5, keyword: '')
        .then((value) {
      if (value.success) {
        generalPostListHome.value = value.data.generalPosts as List<GeneralPostModel>;
        isLoadGeneralPostListHome.value = true;
      }
    });
  }

  Future<void> getPetitionPostListHome() async {
    await _petitionPostRepository
        .getPetitionBoard(page: 0, size: 5, status: "ACTIVE")
        .then((value) {
      if (value.success) {
        petitionListHome.value = value.data.petitionPosts as List<PetitionPostModel>;
        isLoadPetitionListHome.value = true;
      }
    });
  }

  Future<void> getBusList() async {
    await _busRepository.getBusListFromStation(stationName: "단국대정문").then((value) async {
      if (value.success) {
        busListOfJungMoon.value = value.data as List<BusModel>;
        await _busRepository.getBusListFromStation(stationName: "곰상").then((value) {
          if (value.success) {
            busListOfGomSang.value = value.data as List<BusModel>;
            if (busListOfJungMoon.isNotEmpty && busListOfGomSang.isNotEmpty) {
              isLoadBusList.value = true;
            }
          }
        });
      }
    });
  }

  BusModel findJungMoonBusByNo(String no) {
    return busListOfJungMoon.firstWhere((p0) => p0.busNo == no);
  }

  BusModel findGomSangBusByNo(String no) {
    return busListOfGomSang.firstWhere((p0) => p0.busNo == no);
  }

}
