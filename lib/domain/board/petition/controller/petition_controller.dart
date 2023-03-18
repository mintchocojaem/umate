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

  void getPetitionBoard(int page , int size){
    petitionRepository.getPetitionBoard(page, size).then((value) {
      if (value != null) {
        _petitionBoard.value = value;
        _isLoadPetitionBoard.value = true;
      }
    });
  }

  void refreshPetitionBoard(){
    getPetitionBoard(0, 5);
  }

}
