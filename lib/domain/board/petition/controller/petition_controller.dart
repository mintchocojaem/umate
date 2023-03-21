import 'package:get/get.dart';

import '../model/petition_model.dart';
import '../repository/petition_repository.dart';



class PetitionController extends GetxController {

  final PetitionRepository petitionRepository;

  PetitionController({required this.petitionRepository});

  @override
  void onInit() {
    refreshPetitionBoard();
    super.onInit();
  }

  final RxList<PetitionModel> _petitionBoard = <PetitionModel>[].obs;
  final RxBool _isLoadPetitionBoard = false.obs;

  List<PetitionModel> get petitionBoard => _petitionBoard;
  bool get isLoadPetitionBoard => _isLoadPetitionBoard.value;

  List<PetitionModel> getPetitionBoard(int page , int size, String status){
    petitionRepository.getPetitionBoard(page, size, status).then((value) {
      if (value != null) {
        _petitionBoard.value = value;
        _isLoadPetitionBoard.value = true;
        return value;
      }
    });
    return [];
  }

  void refreshPetitionBoard({String? status}){
    getPetitionBoard(0, 5, status ?? "ACTIVE");
  }

  Future<PetitionModel?> getPetition(String token, int id) {
    return petitionRepository.getPetition(token, id);
  }

}
