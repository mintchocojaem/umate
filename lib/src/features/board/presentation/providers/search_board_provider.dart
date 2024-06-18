import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:umate/src/features/board/domain/use_cases/search_all_post.dart';

import '../../domain/models/search_result.dart';

final searchBoardProvider =
    AsyncNotifierProvider.autoDispose<SearchBoardNotifier, SearchResult?>(
  () => SearchBoardNotifier(),
);

class SearchBoardNotifier extends AutoDisposeAsyncNotifier<SearchResult?> {
  CancelToken? _cancelToken;

  @override
  FutureOr<SearchResult?> build() {
    // TODO: implement build
    return null;
  }

  Future<void> search({
    required String keyword,
  }) async {

    _cancelToken?.cancel();
    _cancelToken = CancelToken();

    state = const AsyncLoading();
    //나중에 search하면 DTO로 petition type, coalition Type 넘겨줘야함
    state = await AsyncValue.guard(
      () => ref.read(
        searchAllPostProvider(
          SearchAllPostParams(keyword: keyword),
        ),
      ),
    );
  }
}
