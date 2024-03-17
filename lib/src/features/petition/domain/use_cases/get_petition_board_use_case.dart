import '../../../../core/utils/use_case.dart';
import '../models/petition_board_model.dart';
import '../repositories/petition_repository.dart';

class GetPetitionBoardParams {
  final String? keyword;
  final String? status;
  final int? bodySize;
  final int? page;
  final int? size;

  GetPetitionBoardParams({
    this.keyword,
    this.status,
    this.bodySize,
    this.page,
    this.size,
  });
}

class GetPetitionBoardUseCase extends UseCase<PetitionBoardModel, GetPetitionBoardParams>{
  final PetitionRepository petitionRepository;

  GetPetitionBoardUseCase({required this.petitionRepository});

  @override
  Future<PetitionBoardModel> execute(GetPetitionBoardParams params) async {
    return await petitionRepository.getPetitionBoard(
      keyword: params.keyword,
      status: params.status,
      bodySize: params.bodySize,
      page: params.page,
      size: params.size,
    );
  }
}
