import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/utils/use_case.dart';
import '../repositories/auth_repository.dart';

class SendSmsCodeParams {
  final String signUpToken;
  final String phoneNumber;

  SendSmsCodeParams({
    required this.signUpToken,
    required this.phoneNumber,
  });
}

class SendSmsCodeUseCase extends UseCase<bool, SendSmsCodeParams> {
  final AuthRepository authRepository;

  SendSmsCodeUseCase({
    required this.authRepository,
  });

  @override
  Future<AsyncValue<bool>> call({
    required SendSmsCodeParams params,
  }) async {
    return await AsyncValue.guard(
      () => authRepository.sendSmsCode(
        signUpToken: params.signUpToken,
        phoneNumber: params.phoneNumber,
      ),
    );
  }
}
