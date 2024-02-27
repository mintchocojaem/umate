import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/utils/async_result.dart';
import '../../../../core/utils/use_case.dart';
import '../repositories/auth_repository.dart';

class SendSignUpCodeParams {
  final String signUpToken;
  final String phoneNumber;

  SendSignUpCodeParams({
    required this.signUpToken,
    required this.phoneNumber,
  });
}

class SendSignUpCodeUseCase extends UseCase<bool, SendSignUpCodeParams> {
  final AuthRepository authRepository;

  SendSignUpCodeUseCase({
    required this.authRepository,
  });

  @override
  Future<AsyncValue<bool>> call({
    required SendSignUpCodeParams params,
  }) async {
    return await AsyncResult.fetch(
      () => authRepository.sendSignUpCode(
        signUpToken: params.signUpToken,
        phoneNumber: params.phoneNumber,
      ),
    );
  }
}
