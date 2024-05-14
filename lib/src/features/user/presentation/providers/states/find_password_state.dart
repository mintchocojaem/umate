sealed class FindPasswordState{
  const FindPasswordState();
}

class FindPasswordInitialState extends FindPasswordState {
  const FindPasswordInitialState();
}

class FindPasswordLoadingState extends FindPasswordState {
  const FindPasswordLoadingState();
}

class FindPasswordResetCodeSuccessState extends FindPasswordState {
  const FindPasswordResetCodeSuccessState();
}

class FindPasswordSuccessState extends FindPasswordState {
  const FindPasswordSuccessState();
}

class FindPasswordFailureState extends FindPasswordState {
  final String message;
  const FindPasswordFailureState({
    required this.message,
  });
}