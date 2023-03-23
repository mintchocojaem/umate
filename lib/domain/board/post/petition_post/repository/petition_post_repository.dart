import '../model/petition_post_model.dart';
import '../provider/petition_post_provider.dart';

class PetitionPostRepository {
  final PetitionPostProvider petitionPostProvider;

  PetitionPostRepository({required this.petitionPostProvider});

  //get petition board list
  Future<List<PetitionPostModel>?> getPetitionPostBoard(int page, int size, String status) async {
    return await petitionPostProvider.getPetitionPostBoard(page, size, status);
  }

  //get petition
  Future<PetitionPostModel?> getPetitionPost(String token, int id) async {
    return await petitionPostProvider.getPetitionPost(token, id);
  }

}
