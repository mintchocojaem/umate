import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/utils/use_case.dart';
import '../../data/repositories/search_remote_repository.dart';
import '../models/search_result.dart';

final searchAllPostProvider =
    Provider.autoDispose.family<Future<SearchResult>, SearchAllPostParams>(
  (ref, params) => SearchAllPost(
    searchRemoteRepository: ref.watch(searchRemoteRepositoryProvider),
  )(params),
);

class SearchAllPostParams extends UseCaseParams {
  final CancelToken? cancelToken;
  final String keyword;
  final int? page;

  const SearchAllPostParams({
    this.cancelToken,
    required this.keyword,
    this.page,
  });

  @override
  // TODO: implement props
  List<Object?> get props => [cancelToken, page];
}

class SearchAllPost extends UseCase<SearchResult, SearchAllPostParams> {
  final SearchRemoteRepository searchRemoteRepository;

  SearchAllPost({required this.searchRemoteRepository});

  @override
  Future<SearchResult> call(SearchAllPostParams params) {
    // TODO: implement call
    return searchRemoteRepository.searchPost(
      cancelToken: params.cancelToken,
      keyword: params.keyword,
      page: params.page,
      size: 10,
      bodySize: 200,
    );
  }
}
