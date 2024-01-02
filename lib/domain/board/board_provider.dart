import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../domain.dart';

final searchKeywordProvider = StateProvider<String>((ref) => '');

final petitionStatusProvider = StateProvider<PetitionStatus>((ref) {
  return const PetitionStatus.active();
});

final homeBoardProvider = FutureProvider<Board>((ref) async {
  return await ref.read(boardRepositoryProvider).getPetitionBoard(
        page: 0,
        size: 5,
        bodySize: 50,
        status: const PetitionStatus.active(),
      );
});

final boardProvider =
    AsyncNotifierProvider<BoardNotifier, Board>(() => BoardNotifier());

class BoardNotifier extends AsyncNotifier<Board> {
  int page = 0;
  int size = 10;

  bool isFetchingNext = false;

  Future<void> getPetitionBoard({bool refresh = false}) async {
    if (state.hasValue && state.value!.last && !refresh) {
      // 마지막 페이지일 경우 호출 안함
      return;
    }

    if (!state.hasValue || state.value!.content.isEmpty || refresh) {
      page = 0;
      state = await AsyncValue.guard(
        () async => await ref.read(boardRepositoryProvider).getPetitionBoard(
              page: page,
              size: size,
              bodySize: 200,
              status: ref.read(petitionStatusProvider),
              keyword: ref.read(searchKeywordProvider),
            ),
      );

      ref.invalidate(homeBoardProvider); // 홈 화면에 있는 청원 목록을 갱신
    } else {
      if (isFetchingNext) {
        // 스크롤 시 중복 요청 방지
        return;
      }
      isFetchingNext = true;

      state = await AsyncValue.guard(
        () async => await ref.read(boardRepositoryProvider).getPetitionBoard(
              page: page,
              size: size,
              bodySize: 200,
              status: ref.read(petitionStatusProvider),
              keyword: ref.read(searchKeywordProvider),
            ),
      ).then((board) => AsyncData(
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
    ref.listen(petitionStatusProvider, (previous, next) async {
      if (previous != next) {
        state = const AsyncLoading();
        await getPetitionBoard(refresh: true);
      }
    });
    return state.value!;
  }
}
