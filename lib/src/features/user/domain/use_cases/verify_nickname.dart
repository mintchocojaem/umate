import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/utils/use_case.dart';
import '../../data/repositories/auth_remote_repository.dart';

final verifyNicknameProvider = Provider.autoDispose<VerifyNickname>(
  (ref) => VerifyNickname(
    authRepository: ref.watch(authRemoteRepositoryProvider),
  ),
);

class VerifyNicknameParams extends UseCaseParams {
  final String nickname;

  const VerifyNicknameParams({
    required this.nickname,
  });

  @override
  // TODO: implement props
  List<Object?> get props => [nickname];
}

class VerifyNickname extends UseCase<bool, VerifyNicknameParams> {
  final AuthRemoteRepository authRepository;

  VerifyNickname({
    required this.authRepository,
  });

  @override
  Future<bool> call(VerifyNicknameParams params) async {
    // TODO: implement call
    return await authRepository.verifyNickname(
      nickname: params.nickname,
    );
  }
}
