sealed class SignUpState {
  const SignUpState();
}

class SignUpInitialState extends SignUpState {
  const SignUpInitialState();
}

class SignUpLoadingState extends SignUpState {
  const SignUpLoadingState();
}

class SignUpCodeSentState extends SignUpState {
  const SignUpCodeSentState();
}

class SignUpSuccessState extends SignUpState {
  final String studentName;
  final String studentId;
  final String password;

  const SignUpSuccessState({
    required this.studentName,
    required this.studentId,
    required this.password,
  });
}

class SignUpFailureState extends SignUpState {
  final String message;

  const SignUpFailureState({
    required this.message,
  });
}
