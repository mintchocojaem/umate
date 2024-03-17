import 'package:danvery/src/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/utils/use_case.dart';
import '../models/token_model.dart';
import '../repositories/auth_repository.dart';

final loginUseCaseProvider = Provider.autoDispose<LoginUseCase>(
  (ref) => LoginUseCase(
    authRepository: ref.read(authRepositoryImplProvider),
  ),
);

class LoginParams {
  final String studentId;
  final String password;

  const LoginParams({
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
  Future<TokenModel> execute(LoginParams params) async {
    // TODO: implement execute
    return await authRepository.login(
      studentId: params.studentId,
      password: params.password,
    );
  }
}
