import 'package:flutter/material.dart';

import '../../../domain/models/search_result.dart';

@immutable
sealed class SearchState {
  const SearchState();
}

final class SearchInitialState extends SearchState {
  const SearchInitialState();
}

final class SearchLoadingState extends SearchState {
  const SearchLoadingState();
}

final class SearchSuccessState extends SearchState {
  final SearchResult searchResult;

  const SearchSuccessState({
    required this.searchResult,
  });
}

final class SearchFailureState extends SearchState {
  final String message;
  final bool isCanceled;

  const SearchFailureState({
    required this.message,
    required this.isCanceled,
  });
}
