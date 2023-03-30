import 'package:danvery/domain/board/petition_board/provider/petition_board_provider.dart';
import 'package:danvery/utils/dto/api_response_dto.dart';

class PetitionBoardRepository{
  final PetitionBoardProvider _petitionBoardProvider;

  static final PetitionBoardRepository _singleton =
  PetitionBoardRepository._internal(PetitionBoardProvider());

  PetitionBoardRepository._internal(this._petitionBoardProvider);

  factory PetitionBoardRepository() => _singleton;

  //get petition board list
  Future<ApiResponseDTO> getPetitionBoard(
      {required int page,required int size,required String status}) async {
    return await _petitionBoardProvider.getPetitionPostBoard(page, size, status);
  }

}
