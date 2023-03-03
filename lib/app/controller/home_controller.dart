import 'package:danvery/app/controller/login_controller.dart';
import 'package:danvery/app/controller/main_controller.dart';
import 'package:danvery/app/data/model/petition_model.dart';
import 'package:get/get.dart';

import '../data/model/post_model.dart';
import '../data/repository/board_repository.dart';

class HomeController extends GetxController {

  final BoardRepository boardRepository;

  HomeController({required this.boardRepository});

  @override
  void onInit() {
    getGeneralBoard(0, 5);
    getPetitionBoard(0, 5);
    super.onInit();
  }

  final RxList<PostModel> _generalBoard = <PostModel>[].obs;
  final RxBool _isLoadGeneralBoard = false.obs;

  final RxList<PetitionModel> _petitionBoard = <PetitionModel>[].obs;
  final RxBool _isLoadPetitionBoard = false.obs;

  List<PostModel> get generalBoard => _generalBoard;
  bool get isLoadGeneralBoard => _isLoadGeneralBoard.value;

  List<PetitionModel> get petitionBoard => _petitionBoard;
  bool get isLoadPetitionBoard => _isLoadPetitionBoard.value;

  void getGeneralBoard(int page , int size){
    boardRepository.getGeneralBoard(page, size).then((value) {
      if (value != null) {
        _generalBoard.value = value;
        _isLoadGeneralBoard.value = true;
      }
    });
  }

  void getPetitionBoard(int page , int size){
    boardRepository.getPetitionBoard(page, size).then((value) {
      if (value != null) {
        _petitionBoard.value = value;
        _isLoadPetitionBoard.value = true;
      }
    });
  }


}
