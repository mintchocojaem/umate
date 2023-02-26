import 'package:danvery/app/controller/login_controller.dart';
import 'package:danvery/app/controller/main_controller.dart';
import 'package:danvery/app/data/model/petition_model.dart';
import 'package:get/get.dart';

import '../data/model/post_model.dart';
import '../data/repository/board_repository.dart';

class HomeController extends GetxController {

  static HomeController get to => Get.find();

  final BoardRepository boardRepository;

  final String accessToken = Get.find<LoginController>().loginModel.accessToken;

  HomeController({required this.boardRepository});

  @override
  void onInit() {
    getSuggestionBoardList(accessToken, 0, 5);
    getPetitionBoardList(accessToken, 0, 5);
    super.onInit();
  }

  final RxList<PostModel> _suggestionBoard = <PostModel>[].obs;

  final RxList<PetitionModel> _petitionBoard = <PetitionModel>[].obs;

  List<PostModel> get suggestionBoard => _suggestionBoard;

  List<PetitionModel> get petitionBoard => _petitionBoard;

  void getSuggestionBoardList(String accessToken, int page , int size){
    boardRepository.getSuggestionBoard(accessToken, page, size).then((value) {
      _suggestionBoard.value = value;
    });
  }

  void getPetitionBoardList(String accessToken, int page , int size){
    boardRepository.getPetitionBoard(accessToken, page, size).then((value) {
      _petitionBoard.value = value;
    });
  }


}
