import 'package:danvery/src/features/auth/data/data.dart';
import 'package:danvery/src/features/auth/domain/domain.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final signUpRepositoryProvider = Provider.autoDispose<SignUpRepository>((ref) {
  return SignUpRepository(authDataSource: ref.watch(authApiProvider));
});

class SignUpRepository {
  final AuthApi _authDataSource;

  SignUpRepository({
    required AuthApi authDataSource,
  }) : _authDataSource = authDataSource;

  Future<SignUpModel> verifyStudent({
    required String dkuStudentId,
    required String dkuPassword,
  }) async {
    return await _authDataSource.verifyStudent(
      dkuStudentId: dkuStudentId,
      dkuPassword: dkuPassword,
    );
  }
}
