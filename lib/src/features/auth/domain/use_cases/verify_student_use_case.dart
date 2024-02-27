import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/utils/use_case.dart';
import '../models/sign_up_info_model.dart';
import '../repositories/auth_repository.dart';

class VerifyStudentParams {
  final String dkuStudentId;
  final String dkuPassword;

  VerifyStudentParams({
    required this.dkuStudentId,
    required this.dkuPassword,
  });
}

class VerifyStudentUseCase
    extends UseCase<SignUpInfoModel, VerifyStudentParams> {
  final AuthRepository authRepository;

  VerifyStudentUseCase({
    required this.authRepository,
  });

  @override
  Future<AsyncValue<SignUpInfoModel>> call({
    required VerifyStudentParams params,
  }) async {
    return await AsyncValue.guard(
      () => authRepository.verifyStudent(
        dkuStudentId: params.dkuStudentId,
        dkuPassword: params.dkuPassword,
      ),
    );
  }
}
