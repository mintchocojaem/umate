import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/domain.dart';
import '../data.dart';

final signUpRepositoryProvider = Provider.autoDispose<SignUpRepositoryImpl>((ref) {
  return SignUpRepositoryImpl(authDataSource: ref.watch(authApiProvider));
});

class SignUpRepositoryImpl extends SignUpRepository{

  final AuthApi _authDataSource;

  SignUpRepositoryImpl({
    required AuthApi authDataSource,
  }) : _authDataSource = authDataSource;

  @override
  Future<SignUpModel> verifyStudent(CancelToken? cancelToken, {
    required String studentId,
    required String studentPassword,
  }) async{
    return await _authDataSource.verifyStudent(
      cancelToken,
      studentId: studentId,
      studentPassword: studentPassword,
    );
  }

}
