import 'package:get/get.dart';

import '../model/petition_post_model.dart';
import '../repository/petition_post_repository.dart';

class PetitionController extends GetxController {
  final PetitionPostRepository petitionRepository;

  PetitionController({required this.petitionRepository});


  Future<List<PetitionPostModel>?> getPetitionListHome(int page, int size, String status) async{
    return petitionRepository.getPetitionPostBoard(page, size, status);
  }

  Future<List<PetitionPostModel>?> getPetitionListBoard(int page, int size, String status) async{
    return petitionRepository.getPetitionPostBoard(page, size, status);
  }

  Future<PetitionPostModel?> getPetition(String token, int id) {
    return petitionRepository.getPetitionPost(token, id);
  }
}
