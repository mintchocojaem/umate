import '../models/petition_board_model.dart';

abstract class PetitionRepository {

  Future<PetitionBoardModel> getPetitionBoard({
    String? keyword,
    String? status,
    int? bodySize,
    int? page,
    int? size,
  });

}