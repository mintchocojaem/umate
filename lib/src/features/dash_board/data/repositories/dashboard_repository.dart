import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/services/network/network_client_service.dart';
import '../../../../core/utils/repository.dart';
import '../../domain/models/home_board.dart';

final dashBoardRepositoryProvider = Provider.autoDispose<DashBoardRepository>(
  (ref) => DashBoardRepository(
    networkClientService: ref.watch(networkClientServiceProvider),
  ),
);

class DashBoardRepository extends RemoteRepository {
  DashBoardRepository({required super.networkClientService});

  Future<HomeBoard> getHomeBoard({
    CancelToken? cancelToken,
  }) async {
    final result = await networkClientService.request(
      path: '/main',
      method: RequestType.get,
      cancelToken: cancelToken,
    );

    return HomeBoard.fromJson(result.data);
  }
}
