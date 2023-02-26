import 'package:danvery/app/data/model/petition_model.dart';
import 'package:danvery/app/data/model/post_model.dart';

import '../provider/board_provider.dart';

//로그인이랑 똑같이 리팩토링 할 것
class BoardRepository {
  final BoardProvider boardProvider;

  BoardRepository({required this.boardProvider});

  //get suggestion board list
  Future<List<PostModel>> getSuggestionBoard(
      String accessToken, int page, int size) async {
    return await boardProvider.getSuggestionBoardList(accessToken, page, size);
  }

  //get petition board list
  Future<List<PetitionModel>> getPetitionBoard(
      String accessToken, int page, int size) async {
    return await boardProvider.getPetitionBoardList(accessToken, page, size);
  }

}
