import 'package:danvery/core/dto/api_response_dto.dart';
import 'package:danvery/domain/board/post/petition_post/model/petition_post_write_model.dart';
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

  //write petition
  Future<ApiResponseDTO> writePetitionPost(
      {required String token,
      required PetitionPostWriteModel petitionPostWriteModel}) async {
    return await _petitionPostProvider.writePetitionPost(
        token, petitionPostWriteModel);
  }

  //delete petition
  Future<ApiResponseDTO> deletePetitionPost(
      {required String token, required int id}) async {
    return await _petitionPostProvider.deletePetitionPost(token, id);
  }

  //report petition
  Future<ApiResponseDTO> reportPetitionPost(
      {required String token, required int id, required String categoryName}) async {
    return await _petitionPostProvider.reportPetitionPost(token, id, categoryName);
  }
}
