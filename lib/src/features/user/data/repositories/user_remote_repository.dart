import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/services/network/network_client_service.dart';
import '../../../../core/utils/repository.dart';
import '../../domain/models/user_info.dart';

final userRemoteRepositoryProvider = Provider.autoDispose<UserRemoteRepository>(
  (ref) => UserRemoteRepository(
    networkClientService: ref.watch(networkClientServiceProvider),
  ),
);

class UserRemoteRepository extends RemoteRepository {
  UserRemoteRepository({
    required super.networkClientService,
  });

  Future<UserInfo> getUserInfo() async {
    final response = await networkClientService.request(
        path: '/user',
        method: RequestType.get,
    );
    return UserInfo.fromJson(response.data);
  }

  Future<bool> deleteUser() async {
    final response = await networkClientService.request(
        path: '/user',
        method: RequestType.delete,
    );
    return response.statusCode == 200;
  }

}
