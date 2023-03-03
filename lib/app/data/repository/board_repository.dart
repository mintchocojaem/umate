import 'package:danvery/app/data/model/petition_model.dart';
import 'package:danvery/app/data/model/post_model.dart';

import '../provider/board_provider.dart';

class BoardRepository {
  final BoardProvider boardProvider;

  BoardRepository({required this.boardProvider});

  //get suggestion board list
  Future<List<PostModel>?> getGeneralBoard(int page, int size) async {
    return await boardProvider.getGeneralBoard(page, size);
  }

  //get petition board list
  Future<List<PetitionModel>?> getPetitionBoard(int page, int size) async {
    return await boardProvider.getPetitionBoard(page, size);
  }

}
