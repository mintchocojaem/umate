import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:umate/src/core/services/network/network_client_service.dart';
import '../../../domain/models/petition_post.dart';
import '../../../domain/models/petition_status.dart';
import '../../../domain/models/post_sort.dart';
import '../../../domain/use_cases/get_petition_board_use_case.dart';
import '../../../domain/use_cases/write_petition_use_case.dart';
import '../../../petition_dependency_injections.dart';
import '../states/board_state.dart';

class PetitionBoardNotifier extends AutoDisposeNotifier<BoardState> {
  CancelToken? _cancelToken;

  @override
  BoardState build() {
    // TODO: implement build
    state = const BoardInitialState();
    final sort = ref.watch(petitionBoardSortProvider);
    final status = ref.watch(petitionBoardCategoryProvider);
    getPetitionBoard(sort: sort, status: status);
    return state;
  }

  Future<void> getPetitionBoard({
    required PostSort sort,
    required PetitionStatus status,
    int page = 0,
    bool isFetchMore = false,
  }) async {

    if (!isFetchMore) {
      state = const BoardLoadingState();
    }

    if (state is BoardSuccessState) {
      final successState = state as BoardSuccessState<PetitionPost>;

      if (successState.isFetching || !successState.board.hasNext) {
        return;
      } else {
        state = successState.copyWith(isFetchMore: true);
      }

      _cancelToken?.cancel();
      _cancelToken = CancelToken();

      final result = await ref.read(getPetitionBoardUseCaseProvider)(
        GetPetitionBoardParams(
          cancelToken: _cancelToken,
          status: status,
          page: page,
          sort: [sort],
        ),
      );

      state = result.fold(
        (success) => BoardSuccessState<PetitionPost>(
          board: successState.board.copyWith(
            content: [...successState.board.content, ...success.content],
            page: success.page,
            totalPages: success.totalPages,
            totalElements: success.totalElements,
            hasNext: success.hasNext,
            size: success.size,
            last: success.last,
            first: success.first,
          ),
          isFetching: false,
        ),
        (failure) => BoardFailureState(
          message: failure.message,
          isCanceled: failure is AppNetworkError &&
              failure.type == DioExceptionType.cancel,
        ),
      );
    } else {

      _cancelToken?.cancel();
      _cancelToken = CancelToken();

      final result = await ref.read(getPetitionBoardUseCaseProvider)(
        GetPetitionBoardParams(
          cancelToken: _cancelToken,
          status: status,
          page: page,
          sort: [sort],
        ),
      );

      state = result.fold(
        (success) => BoardSuccessState<PetitionPost>(
          board: success,
          isFetching: false,
        ),
        (failure) => BoardFailureState(
          message: failure.message,
          isCanceled: failure is AppNetworkError &&
              failure.type == DioExceptionType.cancel,
        ),
      );
    }
  }

  Future<bool> writePetition({
    required String title,
    required String body,
    required List<String> images,
    required List<String> files,
  }) async {
    final result = await ref.read(writePetitionPostUseCaseProvider)(
      WritePetitionPostParams(
        title: title,
        body: body,
        images: images,
        files: files,
      ),
    );

    return result.fold(
      (success) => true,
      (failure) => false,
    );
  }
}
