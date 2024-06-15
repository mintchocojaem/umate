import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/utils/use_case.dart';
import '../../data/repositories/dashboard_repository.dart';
import '../models/home_board.dart';

final getHomeBoardProvider =
    Provider.autoDispose.family<Future<HomeBoard>, GetHomeBoardParams>(
  (ref, params) => GetHomeBoard(
    repository: ref.watch(dashBoardRepositoryProvider),
  )(params),
);

class GetHomeBoardParams extends UseCaseParams {
  final CancelToken? cancelToken;

  const GetHomeBoardParams({
    this.cancelToken,
  });

  @override
  // TODO: implement props
  List<Object?> get props => [cancelToken];
}

class GetHomeBoard extends UseCase<HomeBoard, GetHomeBoardParams> {
  final DashBoardRepository repository;

  GetHomeBoard({required this.repository});

  @override
  Future<HomeBoard> call(GetHomeBoardParams params) {
    // TODO: implement call
    return repository.getHomeBoard(
      cancelToken: params.cancelToken,
    );
  }
}
