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
      {required String token, required int postId}) async {
    return await _petitionPostProvider.getPetitionPost(token, postId);
  }

  //agree petition
  Future<ApiResponseDTO> agreePetitionPost(
      {required String token, required int postId}) async {
    return await _petitionPostProvider.agreePetitionPost(token, postId);
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
      {required String token, required int postId}) async {
    return await _petitionPostProvider.deletePetitionPost(token, postId);
  }

  //report petition
  Future<ApiResponseDTO> reportPetitionPost(
      {required String token, required int postId, required String categoryName}) async {
    return await _petitionPostProvider.reportPetitionPost(token, postId, categoryName);
  }

  //blind petition
  Future<ApiResponseDTO> blindPetitionPost(
      {required String token, required int postId}) async {
    return await _petitionPostProvider.blindPetitionPost(token, postId);
  }

  //unblind petition
  Future<ApiResponseDTO> unBlindPetitionPost(
      {required String token, required int postId}) async {
    return await _petitionPostProvider.unBlindPetitionPost(token, postId);
  }

}
