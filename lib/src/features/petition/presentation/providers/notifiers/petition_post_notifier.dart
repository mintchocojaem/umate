import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:umate/src/features/petition/domain/models/post_report_type.dart';

import '../../../../../core/services/network/network_client_service.dart';
import '../../../domain/models/petition_post.dart';
import '../../../domain/use_cases/agree_petition_use_case.dart';
import '../../../domain/use_cases/get_petition_post_use_case.dart';
import '../../../domain/use_cases/report_post_use_case.dart';
import '../../../petition_dependency_injections.dart';
import '../states/post_state.dart';

class PetitionPostNotifier extends AutoDisposeFamilyNotifier<PostState, int> {
  CancelToken? _cancelToken;

  @override
  PostState build(int arg) {
    // TODO: implement build
    state = const PostInitialState();
    _getPetitionPost(id: arg);
    return state;
  }

  Future<void> _getPetitionPost({
    required int id,
    bool isRefresh = false,
  }) async {
    _cancelToken?.cancel();
    _cancelToken = CancelToken();

    if (!isRefresh) {
      state = const PostLoadingState();
    }

    final result = await ref.read(getPetitionPostUseCaseProvider)(
      GetPetitionPostParams(
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

  Future<void> agreePetitionPost({
    required int id,
  }) async {
    final result = await ref.read(agreePetitionPostUseCaseProvider)(
      AgreePetitionPostParams(
        id: id,
      ),
    );

    final successState = state as PostSuccessState<PetitionPost>;

    result.fold(
      (success) {
        _getPetitionPost(id: id, isRefresh: true);
        state = PostSuccessState<PetitionPost>(
          post: successState.post,
          message: "청원에 동의하였어요.",
        );
      },
      (failure) {
        state = PostSuccessState<PetitionPost>(
          post: successState.post,
          hasError: true,
          message: failure.message,
        );
      },
    );
  }

  Future<void> reportPetitionPost({
    required PostReportType reportType,
  }) async {

    final result = await ref.read(reportPostUseCaseProvider)(
      ReportPostParams(
        id: arg,
        reportType: reportType,
      ),
    );

    final successState = state as PostSuccessState<PetitionPost>;

   state = result.fold(
      (success) => PostSuccessState<PetitionPost>(
        post: successState.post,
        message: "청원이 신고되었어요.",
      ),
      (failure) => PostSuccessState<PetitionPost>(
        post: successState.post,
        hasError: true,
        message: failure.message,
      ),
    );
  }
}
