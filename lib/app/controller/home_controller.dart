import 'package:danvery/app/controller/login_controller.dart';
import 'package:danvery/app/controller/main_controller.dart';
import 'package:danvery/app/data/model/petition_model.dart';
import 'package:get/get.dart';

import '../data/model/post_model.dart';
import '../data/repository/board_repository.dart';

class HomeController extends GetxController {

  static HomeController get to => Get.find();

  final BoardRepository boardRepository;

  HomeController({required this.boardRepository});

  @override
  void onInit() {
    getSuggestionBoardList(0, 5);
    getPetitionBoardList(0, 5);
    super.onInit();
  }

  final RxList<PostModel> _suggestionBoard = <PostModel>[].obs;

  final RxList<PetitionModel> _petitionBoard = <PetitionModel>[].obs;

  List<PostModel> get suggestionBoard => _suggestionBoard;

  List<PetitionModel> get petitionBoard => _petitionBoard;

  void getSuggestionBoardList(int page , int size){
    boardRepository.getSuggestionBoard(page, size).then((value) {
      if (value != null) {
        _suggestionBoard.value = value;
      }
    });
  }

  void getPetitionBoardList(int page , int size){
    boardRepository.getPetitionBoard(page, size).then((value) {
      if (value != null) {
        _petitionBoard.value = value;
      }
    });
  }


}
