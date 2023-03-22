import 'package:get/get.dart';

import '../model/petition_model.dart';
import '../repository/petition_repository.dart';

enum PetitionStatus { active, waiting, answered, expired}

class PetitionController extends GetxController {
  final PetitionRepository petitionRepository;

  PetitionController({required this.petitionRepository});

  final Map<String, String> status = {
    PetitionStatus.active.name.toString().toUpperCase() : "청원 중",
    PetitionStatus.waiting.name.toString().toUpperCase() : "답변 대기 중",
    PetitionStatus.answered.name.toString().toUpperCase() : "답변 완료",
    PetitionStatus.expired.name.toString().toUpperCase() : "기간만료",
  };

  @override
  void onInit() {
    refreshPetitionListHome();
    refreshPetitionListBoard();
    super.onInit();
  }

  final RxList<PetitionModel> _petitionListHome = <PetitionModel>[].obs;
  final RxBool _isLoadPetitionListHome = false.obs;

  List<PetitionModel> get petitionListHome => _petitionListHome;

  bool get isLoadPetitionListHome => _isLoadPetitionListHome.value;

  final RxList<PetitionModel> _petitionListBoard = <PetitionModel>[].obs;
  final RxBool _isLoadPetitionListBoard = false.obs;

  List<PetitionModel> get petitionListBoard => _petitionListBoard;

  bool get isLoadPetitionListBoard => _isLoadPetitionListBoard.value;

  List<PetitionModel> getPetitionListHome(int page, int size, String status) {
    petitionRepository.getPetitionBoard(page, size, status).then((value) {
      if (value != null) {
        _petitionListHome.value = value;
        _isLoadPetitionListHome.value = true;
        return value;
      }
    });
    return [];
  }

  List<PetitionModel> getPetitionListBoard(int page, int size, String status) {
    petitionRepository.getPetitionBoard(page, size, status).then((value) {
      if (value != null) {
        _petitionListBoard.value = value;
        _isLoadPetitionListBoard.value = true;
        return value;
      }
    });
    return [];
  }

  void refreshPetitionListHome() {
    getPetitionListHome(
        0, 5, PetitionStatus.active.name.toString().toUpperCase());
  }

  void refreshPetitionListBoard() {
    getPetitionListBoard(
        0, 5, PetitionStatus.active.name.toString().toUpperCase());
  }

  Future<PetitionModel?> getPetition(String token, int id) {
    return petitionRepository.getPetition(token, id);
  }
}
