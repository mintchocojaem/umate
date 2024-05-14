import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../core/services/network/network_client_service.dart';
import '../../../domain/use_cases/get_coalition_post_use_case.dart';
import '../../../petition_dependency_injections.dart';
import '../states/post_state.dart';

class CoalitionPostNotifier extends AutoDisposeFamilyNotifier<PostState, int> {
  CancelToken? _cancelToken;

  @override
  PostState build(int arg) {
    // TODO: implement build
    state = const PostInitialState();
    _getCoalitionPost(id: arg);
    return state;
  }

  Future<void> _getCoalitionPost({
    required int id,
  }) async {
    _cancelToken?.cancel();
    _cancelToken = CancelToken();

    state = const PostLoadingState();

    final result = await ref.read(getCoalitionPostUseCaseProvider)(
      GetCoalitionPostParams(
        cancelToken: _cancelToken,
        id: id,
      ),
    );

    state = result.fold(
      (success) => PostSuccessState(
        post: success,
      ),
      (failure) => PostFailureState(
        message: failure.message,
        isCanceled: failure is AppNetworkError &&
            failure.type == DioExceptionType.cancel,
      ),
    );
  }
}
