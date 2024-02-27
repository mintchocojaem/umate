import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/utils/async_result.dart';
import '../../../../core/utils/auth_validator.dart';
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

class LoginUseCase extends UseCase<TokenModel, LoginParams> with AuthValidator {
  final AuthRepository authRepository;

  LoginUseCase({
    required this.authRepository,
  });

  @override
  Future<AsyncValue<TokenModel>> call({
    required LoginParams params,
  }) async {
    return await AsyncResult.fetch(
      () {
        final studentIdError = validateStudentId(studentId: params.studentId);
        if (studentIdError != null) {
          throw Exception(studentIdError);
        }

        final passwordError = validatePassword(password: params.password);
        if (passwordError != null) {
          throw Exception(passwordError);
        }

        return authRepository.login(
          studentId: params.studentId,
          password: params.password,
        );
      },
    );
  }
}
