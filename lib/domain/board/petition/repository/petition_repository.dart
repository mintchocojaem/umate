import '../model/petition_model.dart';
import '../provider/petition_provider.dart';

class PetitionRepository {
  final PetitionProvider _petitionProvider = PetitionProvider();

  //get petition board list
  Future<List<PetitionModel>?> getPetitionBoard(int page, int size) async {
    return await _petitionProvider.getPetitionBoard(page, size);
  }

}
