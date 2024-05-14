import '../../../../core/utils/use_case.dart';
import '../models/token.dart';
import '../repositories/user_repository.dart';

class LoginParams {
  final String studentId;
  final String password;

  const LoginParams({
    required this.studentId,
    required this.password,
  });
}

class LoginUseCase extends UseCase<Token, LoginParams> {
  final UserRepository userRepository;

  LoginUseCase({
    required this.userRepository,
  });

  @override
  Future<Token> execute(LoginParams params) async {
    // TODO: implement execute
    return await userRepository.login(
      studentId: params.studentId,
      password: params.password,
    );
  }
}
