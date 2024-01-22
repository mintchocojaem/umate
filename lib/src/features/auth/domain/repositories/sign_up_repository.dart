import 'package:dio/dio.dart';

import '../domain.dart';


abstract class SignUpRepository {
  Future<SignUpEntity> verifyStudent(
    CancelToken? cancelToken, {
    required String studentId,
    required String studentPassword,
  });
}
