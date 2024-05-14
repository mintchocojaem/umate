import 'package:dio/dio.dart';

import '../../../../core/utils/use_case.dart';
import '../models/coalition_post.dart';
import '../repositories/petition_repository.dart';

class GetCoalitionPostParams {
  final CancelToken? cancelToken;
  final int id;

  GetCoalitionPostParams({
    this.cancelToken,
    required this.id,
  });
}

class GetCoalitionPostUseCase
    extends UseCase<CoalitionPost, GetCoalitionPostParams> {
  final PetitionRepository petitionRepository;

  GetCoalitionPostUseCase({
    required this.petitionRepository,
  });

  @override
  Future<CoalitionPost> execute(GetCoalitionPostParams params) async {
    return await petitionRepository.getCoalitionPost(
      cancelToken: params.cancelToken,
      id: params.id,
    );
  }
}
