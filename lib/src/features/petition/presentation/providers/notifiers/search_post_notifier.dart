import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../core/services/network/network_client_service.dart';
import '../../../domain/use_cases/search_post_use_case.dart';
import '../../../petition_dependency_injections.dart';
import '../states/search_state.dart';

class SearchPostNotifier extends AutoDisposeNotifier<SearchState> {
  CancelToken? _cancelToken;

  @override
  SearchState build() {
    // TODO: implement build
    return const SearchInitialState();
  }

  Future<void> searchPost({
    String? keyword,
  }) async {
    _cancelToken?.cancel();
    _cancelToken = CancelToken();

    state = const SearchLoadingState();

    final result = await ref.read(searchPostUseCaseProvider)(
      SearchPostParams(
        cancelToken: _cancelToken,
        keyword: keyword,
      ),
    );

    state = result.fold(
      (success) => SearchSuccessState(
        searchResult: success,
      ),
      (failure) => SearchFailureState(
        message: failure.message,
        isCanceled: failure is AppNetworkError &&
            failure.type == DioExceptionType.cancel,
      ),
    );
  }
}
