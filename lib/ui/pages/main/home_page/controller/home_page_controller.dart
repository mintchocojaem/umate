import 'package:danvery/domain/board/post/general_post/model/general_post_model.dart';
import 'package:danvery/domain/board/post/general_post/repository/general_post_repository.dart';
import 'package:danvery/domain/board/post/petition_post/model/petition_post_model.dart';
import 'package:danvery/domain/board/post/petition_post/repository/petition_post_repository.dart';
import 'package:danvery/domain/bus/model/bus_model.dart';
import 'package:danvery/domain/bus/repository/bus_repository.dart';
import 'package:danvery/service/login/login_service.dart';
import 'package:get/get.dart';

class HomePageController extends GetxController {
  final GeneralPostRepository _generalPostRepository = GeneralPostRepository();
  final PetitionPostRepository _petitionPostRepository =
      PetitionPostRepository();
  final BusRepository _busRepository = BusRepository();

  final LoginService loginService = Get.find<LoginService>();

  final RxList<GeneralPostModel> _generalPostListHome =
      <GeneralPostModel>[].obs;
  final RxBool _isLoadGeneralPostListHome = false.obs;

  List<GeneralPostModel> get generalPostListHome => _generalPostListHome;

  bool get isLoadGeneralPostListHome => _isLoadGeneralPostListHome.value;

  final RxList<PetitionPostModel> _petitionListHome = <PetitionPostModel>[].obs;

  List<PetitionPostModel> get petitionListHome => _petitionListHome;

  final RxBool _isLoadPetitionListHome = false.obs;

  bool get isLoadPetitionListHome => _isLoadPetitionListHome.value;

  final RxList<BusModel> busListOfJungMoon = <BusModel>[].obs;
  final RxList<BusModel> busListOfGomSang = <BusModel>[].obs;

  final RxBool _isLoadBustList = false.obs;

  bool get isLoadBusList => _isLoadBustList.value;

  @override
  void onInit() {

    getBusList();
    getGeneralPostListHome();
    getPetitionPostListHome();
    super.onInit();
  }

  Future<void> getGeneralPostListHome() async {
    _generalPostRepository
        .getGeneralBoard(page: 0, size: 5, keyword: '')
        .then((value) {
      if (value != null) {
        _generalPostListHome.value = value;
        _isLoadGeneralPostListHome.value = true;
      }
    });
  }

  Future<void> getPetitionPostListHome() async {
    _petitionPostRepository
        .getPetitionBoard(page: 0, size: 5, status: "ACTIVE")
        .then((value) {
      if (value != null) {
        _petitionListHome.value = value;
        _isLoadPetitionListHome.value = true;
      }
    });
  }

  Future<void> getBusList() async {
    _busRepository.getBusListFromStation(stationName: "단국대정문").then((value) {
      if (value != null) {
        busListOfJungMoon.value = value;
        _busRepository.getBusListFromStation(stationName: "곰상").then((value) {
          if (value != null) {
            busListOfGomSang.value = value;
            if (busListOfJungMoon.isNotEmpty && busListOfGomSang.isNotEmpty) {
              _isLoadBustList.value = true;
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
