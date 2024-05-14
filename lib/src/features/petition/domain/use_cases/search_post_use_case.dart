import 'package:dio/dio.dart';

import '../../../../core/utils/use_case.dart';
import '../models/search_result.dart';
import '../repositories/petition_repository.dart';

class SearchPostParams {
  final CancelToken? cancelToken;
  final String? keyword;
  final int? page;

  SearchPostParams({
    this.cancelToken,
    this.keyword,
    this.page,
  });
}

class SearchPostUseCase extends UseCase<SearchResult, SearchPostParams> {
  final PetitionRepository petitionRepository;

  SearchPostUseCase({
    required this.petitionRepository,
  });

  @override
  Future<SearchResult> execute(SearchPostParams params) async {
    return await petitionRepository.searchPost(
      cancelToken: params.cancelToken,
      keyword: params.keyword,
      page: params.page,
      size: 20,
      bodySize: 200,
    );
  }
}
