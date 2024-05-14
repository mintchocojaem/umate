import 'package:dio/dio.dart';

import '../../../../core/utils/use_case.dart';
import '../models/petition_post.dart';
import '../repositories/petition_repository.dart';

class GetPetitionPostParams {
  final CancelToken? cancelToken;
  final int id;

  GetPetitionPostParams({
    this.cancelToken,
    required this.id,
  });
}

class GetPetitionPostUseCase
    extends UseCase<PetitionPost, GetPetitionPostParams> {
  final PetitionRepository petitionRepository;

  GetPetitionPostUseCase({
    required this.petitionRepository,
  });

  @override
  Future<PetitionPost> execute(GetPetitionPostParams params) async {
    return await petitionRepository.getPetitionPost(
      cancelToken: params.cancelToken,
      id: params.id,
    );
  }
}
