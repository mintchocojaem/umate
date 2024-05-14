import 'package:dio/dio.dart';

import '../../../../core/utils/use_case.dart';
import '../models/coalition_post.dart';
import '../repositories/petition_repository.dart';

class AgreePetitionPostParams {
  final CancelToken? cancelToken;
  final int id;

  AgreePetitionPostParams({
    this.cancelToken,
    required this.id,
  });
}

class AgreePetitionPostUseCase
    extends UseCase<bool, AgreePetitionPostParams> {
  final PetitionRepository petitionRepository;

  AgreePetitionPostUseCase({
    required this.petitionRepository,
  });

  @override
  Future<bool> execute(AgreePetitionPostParams params) async {
    return await petitionRepository.agreePetition(
      id: params.id,
    );
  }
}
