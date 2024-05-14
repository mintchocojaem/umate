import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../core/services/network/network_client_service.dart';
import '../../../dash_board_dependency_injections.dart';
import '../../../domain/use_cases/get_home_board.dart';
import '../states/home_board_state.dart';

class HomeBoardNotifier extends AutoDisposeNotifier<HomeBoardState> {
  CancelToken? _cancelToken;

  @override
  HomeBoardState build() {
    // TODO: implement build
    state = const HomeBoardInitialState();
    getHomeBoard();
    return state;
  }

  Future<void> getHomeBoard({
    bool isRefresh = false,
  }) async {
    _cancelToken?.cancel();
    _cancelToken = CancelToken();

    if (!isRefresh) {
      state = const HomeBoardLoadingState();
    }

    final result = await ref.read(getHomeBoardUseCaseProvider)(
      GetHomeBoardParams(
        cancelToken: _cancelToken,
      ),
    );

    state = result.fold(
      (success) => state = HomeBoardSuccessState(
        homeBoard: success,
      ),
      (failure) => HomeBoardFailureState(
        message: failure.message,
        isCanceled: failure is AppNetworkError &&
            failure.type == DioExceptionType.cancel,
      ),
    );
  }
}
