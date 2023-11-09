import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../utils/dio_provider.dart';
import '../domain.dart';

final findRepositoryProvider =
Provider<FindRepository>((ref) => FindRepository(ref.read(dioProvider)));

final class FindRepository extends Repository {
  FindRepository(super.dio);

  Future<bool> findUserId(String phoneNumber) async {
    final result = await post(
      path: '/user/find/id',
      data: {
        "phoneNumber": phoneNumber,
      },
    );
    return result.statusCode == 200;
  }

  Future<String?> sendSMStoResetPassword(String phoneNumber) async {
    final result = await post(
      path: '/user/find/pwd',
      data: {
        "phoneNumber": phoneNumber,
      },
    );
    return result.data['token'];
  }

  Future<bool> verifySMStoResetPassword(String token, String code) async {
    final result = await post(
      path: '/user/find/pwd/verify',
      data: {
        "token": token,
        "code": code,
      },
    );
    return result.statusCode == 200;
  }

  Future<bool> resetPassword(String token, String password) async {
    final result = await patch(
      path: '/user/find/pwd/reset',
      data: {
        "token": token,
        "password": password,
      },
    );
    return result.statusCode == 200;
  }

}
