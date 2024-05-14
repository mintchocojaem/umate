import 'package:dio/dio.dart';

import '../../../../core/utils/use_case.dart';
import '../models/board.dart';
import '../models/coalition_post.dart';
import '../models/coalition_type.dart';
import '../models/post_sort.dart';
import '../repositories/petition_repository.dart';

class GetCoalitionBoardParams {
  final CancelToken? cancelToken;
  final String? keyword;
  final int? page;
  final CoalitionType coalitionType;
  final List<PostSort>? sort;

  GetCoalitionBoardParams({
    this.cancelToken,
    required this.coalitionType,
    this.keyword,
    this.page,
    this.sort,
  });
}

class GetCoalitionBoardUseCase
    extends UseCase<Board<CoalitionPost>, GetCoalitionBoardParams> {
  final PetitionRepository petitionRepository;

  GetCoalitionBoardUseCase({
    required this.petitionRepository,
  });

  @override
  Future<Board<CoalitionPost>> execute(GetCoalitionBoardParams params) async {
    return await petitionRepository.getCoalitionBoard(
      cancelToken: params.cancelToken,
      coalitionType: params.coalitionType,
      page: params.page,
      bodySize: 100,
      size: 10,
      sort: params.sort,
    );
  }
}
