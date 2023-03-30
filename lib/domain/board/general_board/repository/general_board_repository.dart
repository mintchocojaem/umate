import 'package:danvery/domain/board/general_board/model/general_board_model.dart';
import 'package:danvery/domain/board/general_board/provider/general_board_provider.dart';
import 'package:danvery/utils/dto/api_response_dto.dart';

class GeneralBoardRepository {
  final GeneralBoardProvider _generalBoardProvider;

  static final GeneralBoardRepository _singleton =
  GeneralBoardRepository._internal(GeneralBoardProvider());

  GeneralBoardRepository._internal(this._generalBoardProvider);

  factory GeneralBoardRepository() => _singleton;

  //get suggestion board list
  Future<ApiResponseDTO> getGeneralBoard(
      {required int page, required int size, required String keyword}) async {
    return await _generalBoardProvider.getGeneralBoard(page, size, keyword);
  }
}
