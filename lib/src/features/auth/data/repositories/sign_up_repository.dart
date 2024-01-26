import 'package:danvery/src/features/auth/data/data.dart';
import 'package:danvery/src/features/auth/domain/domain.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final signUpRepositoryProvider = Provider.autoDispose<SignUpRepository>((ref) {
  return SignUpRepository(signUpApi: ref.watch(signUpApiProvider));
});

class SignUpRepository {
  final SignUpApi signUpApi;

  SignUpRepository({
    required this.signUpApi,
  });

  Future<SignUpModel> verifyStudent({
    required String dkuStudentId,
    required String dkuPassword,
  }) async {
    return await signUpApi.verifyStudent(
      dkuStudentId: dkuStudentId,
      dkuPassword: dkuPassword,
    );
  }
}
