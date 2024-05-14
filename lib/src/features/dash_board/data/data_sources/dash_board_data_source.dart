import 'package:dio/dio.dart';

import '../../../../core/services/network/network_client_service.dart';
import '../../../../core/utils/remote_data_source.dart';
import '../dto/home_board_dto.dart';

class DashBoardDataSource extends RemoteDataSource {
  DashBoardDataSource({required super.networkClientService});

  Future<HomeBoardDTO> getHomeBoard({
    CancelToken? cancelToken,
}) async {
    return request(
      path: '/main',
      method: RequestType.get,
      cancelToken: cancelToken,
      fromJson: HomeBoardDTO.fromJson,
    );
  }
}
