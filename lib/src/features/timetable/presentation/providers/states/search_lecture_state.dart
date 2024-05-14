import 'package:flutter/material.dart';

import '../../../domain/models/lecture_info.dart';

@immutable
sealed class SearchLectureState {
  const SearchLectureState();
}

class SearchLectureInitialState extends SearchLectureState {
  const SearchLectureInitialState();
}

class SearchLectureLoadingState extends SearchLectureState {
  const SearchLectureLoadingState();
}

class SearchLectureOnSearchState extends SearchLectureState {
  final List<LectureInfo> lectures;

  const SearchLectureOnSearchState({
    required this.lectures,
  });
}

class SearchLectureIsTypingState extends SearchLectureState {
  final List<String> lectureNames;

  const SearchLectureIsTypingState({
    required this.lectureNames,
  });
}