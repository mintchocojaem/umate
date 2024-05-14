import 'package:flutter/material.dart';

import '../../../domain/models/board.dart';
import '../../../domain/models/post.dart';

@immutable
sealed class BoardState {
  const BoardState();
}

final class BoardInitialState extends BoardState {
  const BoardInitialState();
}

final class BoardLoadingState extends BoardState {
  const BoardLoadingState();
}

final class BoardSuccessState<T extends Post> extends BoardState {
  final Board<T> board;
  final bool isFetching;

  copyWith({
    Board<T>? board,
    bool? isFetchMore,
  }) {
    return BoardSuccessState(
      board: board ?? this.board,
      isFetching: isFetchMore ?? this.isFetching,
    );
  }

  const BoardSuccessState({
    required this.board,
    this.isFetching = false,
  });
}

final class BoardFailureState extends BoardState {
  final String message;
  final bool isCanceled;

  const BoardFailureState({
    required this.message,
    required this.isCanceled,
  });
}
