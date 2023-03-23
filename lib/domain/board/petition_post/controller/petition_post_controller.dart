import 'package:get/get.dart';

import '../model/petition_post_model.dart';
import '../repository/petition_post_repository.dart';

enum PetitionStatus { active, waiting, answered, expired}

class PetitionController extends GetxController {
  final PetitionPostRepository petitionRepository;

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

  final RxList<PetitionPostModel> _petitionListHome = <PetitionPostModel>[].obs;
  final RxBool _isLoadPetitionListHome = false.obs;

  List<PetitionPostModel> get petitionListHome => _petitionListHome;

  bool get isLoadPetitionListHome => _isLoadPetitionListHome.value;

  final RxList<PetitionPostModel> _petitionListBoard = <PetitionPostModel>[].obs;
  final RxBool _isLoadPetitionListBoard = false.obs;

  List<PetitionPostModel> get petitionListBoard => _petitionListBoard;

  bool get isLoadPetitionListBoard => _isLoadPetitionListBoard.value;

  List<PetitionPostModel> getPetitionListHome(int page, int size, String status) {
    petitionRepository.getPetitionPostBoard(page, size, status).then((value) {
      if (value != null) {
        _petitionListHome.value = value;
        _isLoadPetitionListHome.value = true;
        return value;
      }
    });
    return [];
  }

  List<PetitionPostModel> getPetitionListBoard(int page, int size, String status) {
    petitionRepository.getPetitionPostBoard(page, size, status).then((value) {
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

  Future<PetitionPostModel?> getPetition(String token, int id) {
    return petitionRepository.getPetitionPost(token, id);
  }
}
