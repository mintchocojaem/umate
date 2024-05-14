sealed class FindStudentIdState{
  const FindStudentIdState();
}

class FindStudentIdInitialState extends FindStudentIdState {
  const FindStudentIdInitialState();
}

class FindStudentIdLoadingState extends FindStudentIdState {
  const FindStudentIdLoadingState();
}

class FindStudentIdSuccessState extends FindStudentIdState {
  const FindStudentIdSuccessState();
}

class FindStudentIdFailureState extends FindStudentIdState {
  final String message;
  const FindStudentIdFailureState({
    required this.message,
  });
}