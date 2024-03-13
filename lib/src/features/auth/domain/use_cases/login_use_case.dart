import '../../../../core/utils/use_case.dart';
import '../models/token_model.dart';
import '../repositories/auth_repository.dart';

class LoginParams {
  final String studentId;
  final String password;

  LoginParams({
    required this.studentId,
    required this.password,
  });
}

class LoginUseCase extends UseCase<TokenModel, LoginParams> {
  final AuthRepository authRepository;

  LoginUseCase({
    required this.authRepository,
  });

  @override
  Future<TokenModel> call({
    required LoginParams params,
  }) async {
    return await authRepository.login(
      studentId: params.studentId,
      password: params.password,
    );
  }
}
