import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/utils/use_case.dart';
import '../../data/repositories/bear_eats_remote_repository.dart';
import '../models/bear_eats_post.dart';
import '../models/board.dart';

final getBearEatsBoardProvider = Provider.autoDispose
    .family<Future<Board<BearEatsPost>>, GetBearEatsBoardParams>(
  (ref, params) => GetBearEatsBoard(
    bearEatsRemoteRepository: ref.watch(bearEatsRemoteRepositoryProvider),
  )(params),
);

class GetBearEatsBoardParams extends UseCaseParams {
  final CancelToken? cancelToken;
  final int? page;

  const GetBearEatsBoardParams({
    this.cancelToken,
    this.page,
  });

  @override
  // TODO: implement props
  List<Object?> get props => [cancelToken, page];
}

class GetBearEatsBoard
    extends UseCase<Board<BearEatsPost>, GetBearEatsBoardParams> {
  final BearEatsRemoteRepository bearEatsRemoteRepository;

  GetBearEatsBoard({required this.bearEatsRemoteRepository});

  @override
  Future<Board<BearEatsPost>> call(GetBearEatsBoardParams params) {
    // TODO: implement call
    return bearEatsRemoteRepository.getBoard(
      cancelToken: params.cancelToken,
      page: params.page,
      size: 10,
      bodySize: 200,
    );
  }
}
