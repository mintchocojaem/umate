import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../core/services/network/network_client_service.dart';
import '../../../../core/utils/repository.dart';
import '../../domain/models/user_info.dart';

part 'user_remote_repository.g.dart';

@riverpod
UserRemoteRepository userRemoteRepository(UserRemoteRepositoryRef ref) {
  return UserRemoteRepository(
    client: ref.watch(networkClientServiceProvider),
  );
}

class UserRemoteRepository extends RemoteRepository {
  UserRemoteRepository({
    required super.client,
  });

  Future<UserInfo> getUserInfo() async {
    final response = await client.request(
      path: '/user',
      method: RequestType.get,
    );
    return UserInfo.fromJson(response.data);
  }

  Future<bool> deleteUser() async {
    final response = await client.request(
      path: '/user',
      method: RequestType.delete,
    );
    return response.statusCode == 200;
  }
}
