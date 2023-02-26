import 'package:danvery/app/data/model/petition_model.dart';
import 'package:danvery/app/data/model/post_model.dart';

import '../provider/board_provider.dart';

class BoardRepository {
  final BoardProvider boardProvider;

  BoardRepository({required this.boardProvider});

  //get suggestion board list
  Future<List<PostModel>?> getSuggestionBoard(int page, int size) async {
    return await boardProvider.getSuggestionBoardList(page, size);
  }

  //get petition board list
  Future<List<PetitionModel>?> getPetitionBoard(int page, int size) async {
    return await boardProvider.getPetitionBoardList(page, size);
  }

}
