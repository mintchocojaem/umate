import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/utils/use_case.dart';
import '../../data/repositories/auth_repository_impl.dart';
import '../models/sign_up_info_model.dart';
import '../repositories/auth_repository.dart';

final signUpVerifyStudentUseCaseProvider =
    Provider.autoDispose<SignUpVerifyStudentUseCase>(
  (ref) => SignUpVerifyStudentUseCase(
    authRepository: ref.read(authRepositoryImplProvider),
  ),
);

class SignUpVerifyStudentParams {
  final String dkuStudentId;
  final String dkuPassword;

  const SignUpVerifyStudentParams({
    required this.dkuStudentId,
    required this.dkuPassword,
  });
}

class SignUpVerifyStudentUseCase
    extends UseCase<SignUpInfoModel, SignUpVerifyStudentParams> {
  final AuthRepository authRepository;

  SignUpVerifyStudentUseCase({
    required this.authRepository,
  });

  @override
  Future<SignUpInfoModel> execute(SignUpVerifyStudentParams params) async {
    // TODO: implement execute
    return await authRepository.signUpVerifyStudent(
      dkuStudentId: params.dkuStudentId,
      dkuPassword: params.dkuPassword,
    );
  }
}
