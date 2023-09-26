import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'board.dart';
import 'board_repository.dart';

final boardProvider =
    AsyncNotifierProvider<BoardNotifier, Board?>(() => BoardNotifier());

class BoardNotifier extends AsyncNotifier<Board?> {
  int page = 0;
  int size = 5;
  bool isFetching = false;

  Future<void> getPetitionBoard({bool firstPage = false}) async {

    if (isFetching) {
      return;
    }
    if (!state.hasValue || state.value!.content.isEmpty || firstPage) {
      page = 0;
      isFetching = true;
      state = await AsyncValue.guard(
            () async =>
        await ref.read(boardRepositoryProvider).getPetitionBoard(
          page: page,
          size: size,
          bodySize: 200,
        ),
      );
      isFetching = false;
    } else if (state.hasValue && !state.value!.hasNext) {
      return;
    } else {
      isFetching = true;
      AsyncValue.guard(
            () async =>
        await ref.read(boardRepositoryProvider).getPetitionBoard(
          page: page,
          size: size,
          bodySize: 200,
        )
      ).then((board){
        state = AsyncData(
          state.value!.copyWith(
            content: state.value!.content + board.value!.content,
            hasNext: board.value!.hasNext,
            totalPages: board.value!.totalPages,
            totalElements: board.value!.totalElements,
            page: board.value!.page,
            size: board.value!.size,
            first: board.value!.first,
            last: board.value!.last,
          ),
        );
        page++;
        isFetching = false;
      });
    }
  }

  @override
  FutureOr<Board?> build() async {
    // TODO: implement build
    await getPetitionBoard();
    return state.value;
  }
}
