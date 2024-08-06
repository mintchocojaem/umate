import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../domain/models/student_council/search_result.dart';
import '../../../../domain/use_cases/student_council/search_use_cases.dart';

final searchBoardControllerProvider =
    AsyncNotifierProvider.autoDispose<SearchBoardController, SearchResult?>(
  () => SearchBoardController(),
);

class SearchBoardController extends AutoDisposeAsyncNotifier<SearchResult?> {
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
      () => ref.read(searchUseCasesProvider).searchPost(
            cancelToken: _cancelToken,
            keyword: keyword,
          ),
    );
  }
}
