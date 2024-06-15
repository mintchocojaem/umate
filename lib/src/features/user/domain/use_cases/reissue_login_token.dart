import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/utils/use_case.dart';
import '../../data/repositories/auth_local_repository.dart';
import '../../data/repositories/auth_remote_repository.dart';
import '../models/login_token.dart';

final reissueLoginTokenProvider =
    Provider.autoDispose.family<Future<LoginToken>, ReissueLoginTokenParams>(
  (ref, params) async => await ReissueLoginToken(
    authRemoteRepository: ref.watch(authRemoteRepositoryProvider),
    authLocalRepository: ref.watch(authLocalRepositoryProvider),
  )(params),
);

class ReissueLoginTokenParams extends UseCaseParams {
  final String refreshToken;

  const ReissueLoginTokenParams({
    required this.refreshToken,
  });

  @override
  // TODO: implement props
  List<Object?> get props => [refreshToken];
}

class ReissueLoginToken extends UseCase<LoginToken, ReissueLoginTokenParams> {
  final AuthRemoteRepository authRemoteRepository;
  final AuthLocalRepository authLocalRepository;

  ReissueLoginToken({
    required this.authRemoteRepository,
    required this.authLocalRepository,
  });

  @override
  Future<LoginToken> call(ReissueLoginTokenParams params) async {
    // TODO: implement call
    try {
      final loginToken = await authRemoteRepository.reissueToken(
        refreshToken: params.refreshToken,
      );

      authLocalRepository.saveLoginToken(
        token: loginToken,
      );
      return loginToken;
    } catch (_) {
      authLocalRepository.deleteLoginToken();
      rethrow;
    }
  }
}
