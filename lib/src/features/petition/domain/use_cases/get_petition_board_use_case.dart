import 'package:dio/dio.dart';

import '../../../../core/utils/use_case.dart';
import '../models/board.dart';
import '../models/petition_post.dart';
import '../models/petition_status.dart';
import '../models/post_sort.dart';
import '../repositories/petition_repository.dart';

class GetPetitionBoardParams {
  final CancelToken? cancelToken;
  final String? keyword;
  final PetitionStatus status;
  final int? page;
  final List<PostSort>? sort;

  GetPetitionBoardParams({
    this.cancelToken,
    this.keyword,
    required this.status,
    this.page,
    this.sort,
  });
}

class GetPetitionBoardUseCase
    extends UseCase<Board<PetitionPost>, GetPetitionBoardParams> {
  final PetitionRepository petitionRepository;

  GetPetitionBoardUseCase({
    required this.petitionRepository,
  });

  @override
  Future<Board<PetitionPost>> execute(GetPetitionBoardParams params) async {
    return await petitionRepository.getPetitionBoard(
      cancelToken: params.cancelToken,
      keyword: params.keyword,
      status: params.status,
      bodySize: 100,
      page: params.page,
      size: 10,
      sort: params.sort,
    );
  }
}
