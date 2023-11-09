import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../domain.dart';

final searchKeywordProvider = StateProvider<String>((ref) => '');

final petitionStatusProvider = StateProvider<PetitionStatus>((ref) {
  return const PetitionStatus.active();
});

final boardProvider =
    AsyncNotifierProvider<BoardNotifier, Board>(() => BoardNotifier());

class BoardNotifier extends AsyncNotifier<Board> {
  int page = 0;
  int size = 10;

  bool isFetchingNext = false;

  Future<void> getPetitionBoard({bool init = false}) async {

    if (!state.hasValue || state.value!.content.isEmpty || init) {

      page = 0;
      await AsyncValue.guard(
            () async =>
        await ref.read(boardRepositoryProvider).getPetitionBoard(
          page: page,
          size: size,
          bodySize: 200,
          status: ref.read(petitionStatusProvider),
          keyword: ref.read(searchKeywordProvider),
        ) as Board,
      ).then((value) => state = value);

    } else {

      if(isFetchingNext) {
        // 스크롤 시 중복 요청 방지
        return;
      }
      isFetchingNext = true;

      await AsyncValue.guard(
            () async =>
        await ref.read(boardRepositoryProvider).getPetitionBoard(
          page: page,
          size: size,
          bodySize: 200,
          status: ref.read(petitionStatusProvider),
        )
      ).then((board) => state = AsyncData(
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
      ));
      isFetchingNext = false;
    }

    page++;
  }

  @override
  FutureOr<Board> build() async {
    // TODO: implement build
    getPetitionBoard();
    ref.listen(petitionStatusProvider, (previous, next) async{
      if (previous != next) {
        state = const AsyncLoading();
        await getPetitionBoard(init: true);
      }
    });
    return state.value!;
  }
}
