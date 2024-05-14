import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../domain/use_cases/get_all_lecture_info_use_case.dart';
import '../../../timetable_dependency_injections.dart';
import '../states/search_lecture_state.dart';

class SearchLectureNotifier extends AutoDisposeNotifier<SearchLectureState> {
  CancelToken? _cancelToken;

  @override
  SearchLectureState build() {
    // TODO: implement build
    return const SearchLectureInitialState();
  }

  Future<void> isTyping({
    required String keyword,
  }) async {
    _cancelToken?.cancel();
    _cancelToken = CancelToken();

    if (keyword.isEmpty) {
      state = const SearchLectureInitialState();
      return;
    }

    final result = await ref.read(getAllLectureInfoUseCaseProvider)(
      GetAllLectureInfoParams(
        keyword: keyword,
        cancelToken: _cancelToken,
      ),
    );

    state = result.fold(
      (success) => SearchLectureIsTypingState(
        lectureNames: success.map((e) => e.lectureName).toSet().toList(),
      ),
      (failure) => const SearchLectureIsTypingState(
        lectureNames: [],
      ),
    );
  }

  Future<void> searchLecture({
    required String keyword,
  }) async {
    _cancelToken?.cancel();
    _cancelToken = CancelToken();

    state = const SearchLectureLoadingState();

    final result = await ref.read(getAllLectureInfoUseCaseProvider)(
      GetAllLectureInfoParams(
        keyword: keyword,
        cancelToken: _cancelToken,
      ),
    );

    state = result.fold(
      (success) => SearchLectureOnSearchState(
        lectures: success,
      ),
      (failure) => const SearchLectureOnSearchState(
        lectures: [],
      ),
    );
  }
}
