import '../model/petition_post_model.dart';
import '../provider/petition_post_provider.dart';

class PetitionPostRepository {

  final PetitionPostProvider _petitionPostProvider;

  static final PetitionPostRepository _singleton =
      PetitionPostRepository._internal(PetitionPostProvider());

  PetitionPostRepository._internal(this._petitionPostProvider);

  factory PetitionPostRepository()=> _singleton;

  //get petition board list
  Future<List<PetitionPostModel>?> getPetitionBoard(
      int page, int size, String status) async {
    return await _petitionPostProvider.getPetitionPostBoard(page, size, status);
  }

  //get petition
  Future<PetitionPostModel?> getPetitionPost(String token, int id) async {
    return await _petitionPostProvider.getPetitionPost(token, id);
  }
}
