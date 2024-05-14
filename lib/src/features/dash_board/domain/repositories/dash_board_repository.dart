import 'package:dio/dio.dart';

import '../models/home_board.dart';

abstract class DashBoardRepository {
  Future<HomeBoard> getHomeBoard({
    CancelToken? cancelToken,
  });
}
