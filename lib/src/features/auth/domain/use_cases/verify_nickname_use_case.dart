import '../../../../core/utils/use_case.dart';
import '../repositories/auth_repository.dart';

class VerifyNicknameParams {
  final String nickname;

  VerifyNicknameParams({
    required this.nickname,
  });
}

class VerifyNicknameUseCase extends UseCase<bool, VerifyNicknameParams> {
  final AuthRepository authRepository;

  VerifyNicknameUseCase({
    required this.authRepository,
  });

  @override
  Future<bool> call({
    required VerifyNicknameParams params,
  }) async {
    return await authRepository.verifyNickname(nickname: params.nickname);
  }
}
