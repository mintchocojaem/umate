import '../../../../core/utils/use_case.dart';
import '../models/token.dart';
import '../repositories/user_repository.dart';

class ReissueTokenParams {
  final String refreshToken;

  ReissueTokenParams({
    required this.refreshToken,
  });
}

class ReissueTokenUseCase extends UseCase<Token, ReissueTokenParams> {
  final UserRepository userRepository;

  ReissueTokenUseCase({
    required this.userRepository,
  });

  @override
  Future<Token> execute(ReissueTokenParams params) async {
    // TODO: implement execute
    return await userRepository.reissueToken(
      refreshToken: params.refreshToken,
    );
  }
}
