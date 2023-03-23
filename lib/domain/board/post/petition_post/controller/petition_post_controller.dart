import 'package:get/get.dart';

import '../model/petition_post_model.dart';
import '../repository/petition_post_repository.dart';

enum PetitionStatus { active, waiting, answered, expired}

class PetitionController extends GetxController {
  final PetitionPostRepository petitionRepository;

  PetitionController({required this.petitionRepository});

  final Map<String, String> status = {
    PetitionStatus.active.name.toUpperCase() : "청원 중",
    PetitionStatus.waiting.name.toUpperCase() : "답변 대기 중",
    PetitionStatus.answered.name.toUpperCase() : "답변 완료",
    PetitionStatus.expired.name.toUpperCase() : "기간만료",
  };

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
