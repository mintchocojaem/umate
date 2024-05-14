import '../../../domain/models/home_board.dart';

sealed class HomeBoardState {
  const HomeBoardState();
}

class HomeBoardInitialState extends HomeBoardState {
  const HomeBoardInitialState();
}

class HomeBoardLoadingState extends HomeBoardState {
  const HomeBoardLoadingState();
}

class HomeBoardSuccessState extends HomeBoardState {
  final HomeBoard homeBoard;

  const HomeBoardSuccessState({
    required this.homeBoard,
  });
}

class HomeBoardFailureState extends HomeBoardState {
  final String message;
  final bool isCanceled;

  const HomeBoardFailureState({
    required this.message,
    required this.isCanceled,
  });
}
