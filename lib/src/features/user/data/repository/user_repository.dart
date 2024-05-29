import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/services/network/network_client_service.dart';
import '../../../../core/utils/repository.dart';
import '../../domain/model/token.dart';

final userRepositoryProvider = Provider.autoDispose<UserRepository>(
  (ref) => UserRepository(
    networkClientService: ref.watch(networkClientServiceProvider),
  ),
);

class UserRepository extends Repository {
  UserRepository({
    required super.networkClientService,
  });

  Future<Token> login({
    required String studentId,
    required String password,
  }) async {
    final response = await networkClientService.request(
      path: '/user/login',
      method: RequestType.post,
      data: {
        'studentId': studentId,
        'password': password,
      },
    );
    return Token.fromJson(response.data);
  }
}
