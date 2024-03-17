import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/utils/use_case.dart';
import '../../data/repositories/auth_repository_impl.dart';
import '../repositories/auth_repository.dart';

final signUpVerifyNicknameUseCaseProvider =
    Provider.autoDispose<SignUpVerifyNicknameUseCase>(
  (ref) => SignUpVerifyNicknameUseCase(
    authRepository: ref.read(authRepositoryImplProvider),
  ),
);

class SignUpVerifyNicknameParams {
  final String nickname;

  const SignUpVerifyNicknameParams({
    required this.nickname,
  });
}

class SignUpVerifyNicknameUseCase
    extends UseCase<bool, SignUpVerifyNicknameParams> {
  final AuthRepository authRepository;

  SignUpVerifyNicknameUseCase({
    required this.authRepository,
  });

  @override
  Future<bool> execute(SignUpVerifyNicknameParams params) async {
    // TODO: implement execute
    return await authRepository.signUpVerifyNickname(nickname: params.nickname);
  }
}
