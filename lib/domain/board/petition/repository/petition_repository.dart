import '../model/petition_model.dart';
import '../provider/petition_provider.dart';

class PetitionRepository {
  final PetitionProvider petitionProvider;

  PetitionRepository({required this.petitionProvider});

  //get petition board list
  Future<List<PetitionModel>?> getPetitionBoard(int page, int size, String status) async {
    return await petitionProvider.getPetitionBoard(page, size, status);
  }

  //get petition
  Future<PetitionModel?> getPetition(String token, int id) async {
    return await petitionProvider.getPetition(token, id);
  }

}
