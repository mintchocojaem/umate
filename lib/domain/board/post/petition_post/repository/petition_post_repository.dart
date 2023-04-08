import 'package:danvery/core/dto/api_response_dto.dart';
import 'package:danvery/domain/board/post/petition_post/provider/petition_post_provider.dart';

class PetitionPostRepository {
  final PetitionPostProvider _petitionPostProvider;

  static final PetitionPostRepository _singleton =
      PetitionPostRepository._internal(PetitionPostProvider());

  PetitionPostRepository._internal(this._petitionPostProvider);

  factory PetitionPostRepository() => _singleton;

  //get petition
  Future<ApiResponseDTO> getPetitionPost(
      {required String token, required int id}) async {
    return await _petitionPostProvider.getPetitionPost(token, id);
  }

  //agree petition
  Future<ApiResponseDTO> agreePetitionPost(
      {required String token, required int id}) async {
    return await _petitionPostProvider.agreePetitionPost(token, id);
  }
}
