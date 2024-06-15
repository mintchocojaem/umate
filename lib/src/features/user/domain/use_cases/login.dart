import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/utils/use_case.dart';
import '../../data/repositories/auth_local_repository.dart';
import '../../data/repositories/auth_remote_repository.dart';
import '../models/login_token.dart';

final loginProvider =
    Provider.autoDispose.family<Future<LoginToken>, LoginParams>(
  (ref, params) => Login(
    authRemoteRepository: ref.watch(authRemoteRepositoryProvider),
    authLocalRepository: ref.watch(authLocalRepositoryProvider),
  )(params),
);

class LoginParams extends UseCaseParams {
  final String studentId;
  final String password;

  const LoginParams({
    required this.studentId,
    required this.password,
  });

  @override
  // TODO: implement props
  List<Object?> get props => [studentId, password];
}

class Login extends UseCase<LoginToken, LoginParams> {
  final AuthRemoteRepository authRemoteRepository;
  final AuthLocalRepository authLocalRepository;

  Login({
    required this.authRemoteRepository,
    required this.authLocalRepository,
  });

  @override
  Future<LoginToken> call(LoginParams params) async {
    // TODO: implement call
    final loginToken = await authRemoteRepository.login(
      studentId: params.studentId,
      password: params.password,
    );

    authLocalRepository.saveLoginToken(
      token: loginToken,
    );
    return loginToken;
  }
}
