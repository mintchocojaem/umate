import 'package:dio/dio.dart';

import '../../domain/models/home_board.dart';
import '../../domain/repositories/dash_board_repository.dart';
import '../data_sources/dash_board_data_source.dart';

class DashBoardRepositoryImpl implements DashBoardRepository {
  final DashBoardDataSource dashBoardDataSource;

  DashBoardRepositoryImpl({
    required this.dashBoardDataSource,
  });

  @override
  Future<HomeBoard> getHomeBoard({
    CancelToken? cancelToken,
  }) async {
    // TODO: implement getDashBoard
    final result = await dashBoardDataSource.getHomeBoard();
    return result.mapToModel();
  }
}
