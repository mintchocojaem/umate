import 'package:get/get.dart';
import '../data/model/petition_model.dart';
import '../data/model/post_model.dart';
import '../data/repository/board_repository.dart';

class BoardController extends GetxController {

  final BoardRepository boardRepository;

  BoardController({required this.boardRepository});

  final RxList<PostModel> _generalBoard = <PostModel>[].obs;
  final RxBool _isLoadGeneralBoard = false.obs;

  final RxList<PetitionModel> _petitionBoard = <PetitionModel>[].obs;
  final RxBool _isLoadPetitionBoard = false.obs;

  List<PostModel> get generalBoard => _generalBoard;
  bool get isLoadGeneralBoard => _isLoadGeneralBoard.value;

  List<PetitionModel> get petitionBoard => _petitionBoard;
  bool get isLoadPetitionBoard => _isLoadPetitionBoard.value;

  @override
  void onInit() {
    refreshGeneralBoard();
    refreshPetitionBoard();
    super.onInit();
  }

  void getGeneralBoard(int page , int size){
    boardRepository.getGeneralBoard(page, size).then((value) {
      if (value != null) {
        _generalBoard.value = value;
        _isLoadGeneralBoard.value = true;
      }
    });
  }

  void refreshGeneralBoard(){
   getGeneralBoard(0, 5);
  }

  void getPetitionBoard(int page , int size){
    boardRepository.getPetitionBoard(page, size).then((value) {
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
