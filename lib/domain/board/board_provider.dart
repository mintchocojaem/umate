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
  int bodySize = 200;

  bool isFetchingNext = false;

  Future<bool> getPetitionBoard(
      {bool firstPage = false, bool refresh = false}) async {
    if (state.hasValue && state.value!.last && !firstPage && !refresh) {
      // 마지막 페이지일 경우 호출 안함
      return false;
    }

    if (!state.hasValue || state.value!.content.isEmpty || firstPage || refresh) {
      page = 0;
      state = const AsyncLoading();

      if (refresh) {

        state = await AsyncValue.guard(
          () async => await ref.read(boardRepositoryProvider).getPetitionBoard(
                page: page,
                size: size,
                bodySize: bodySize,
                status: const PetitionStatus.active(),
              ),
        );
        ref
            .read(searchKeywordProvider.notifier)
            .update((state) => '');

        ref
            .read(petitionStatusProvider.notifier)
            .update((state) => const PetitionStatus.active());
      } else {
        state = await AsyncValue.guard(
          () async => await ref.read(boardRepositoryProvider).getPetitionBoard(
                page: page,
                size: size,
                bodySize: bodySize,
                status: ref.read(petitionStatusProvider),
                keyword: ref.read(searchKeywordProvider),
              ),
        );
      }
      ref.invalidate(homeBoardProvider); // 홈 화면에 있는 청원 목록을 갱신
    } else {
      if (isFetchingNext) {
        // 스크롤 시 중복 요청 방지
        return false;
      }
      isFetchingNext = true;

      final result = await AsyncValue.guard(
        () async => await ref.read(boardRepositoryProvider).getPetitionBoard(
              page: page,
              size: size,
              bodySize: bodySize,
              status: ref.read(petitionStatusProvider),
              keyword: ref.read(searchKeywordProvider),
            ),
      );

      if (result.hasError) {
        return false;
      }

      state = AsyncData(
        state.value!.copyWith(
          content: state.value!.content + result.value!.content,
          hasNext: result.value!.hasNext,
          totalPages: result.value!.totalPages,
          totalElements: result.value!.totalElements,
          page: result.value!.page,
          size: result.value!.size,
          first: result.value!.first,
          last: result.value!.last,
        ),
      );
      isFetchingNext = false;
    }

    page++;
    return true;
  }

  @override
  FutureOr<Board> build() async {
    // TODO: implement build
    getPetitionBoard();
    return state.value!;
  }
}
