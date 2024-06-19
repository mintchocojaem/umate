import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/utils/use_case.dart';
import '../../data/repositories/eating_alone_remote_repository.dart';
import '../models/board.dart';
import '../models/eating_alone_post.dart';

final getEatingAloneBoardProvider = Provider.autoDispose
    .family<Future<Board<EatingAlonePost>>, GetEatingAloneBoardParams>(
  (ref, params) => GetEatingAloneBoard(
    eatingAloneRemoteRepository: ref.watch(eatingAloneRemoteRepositoryProvider),
  )(params),
);

class GetEatingAloneBoardParams extends UseCaseParams {
  final CancelToken? cancelToken;
  final int? page;

  const GetEatingAloneBoardParams({
    this.cancelToken,
    this.page,
  });

  @override
  // TODO: implement props
  List<Object?> get props => [cancelToken, page];
}

class GetEatingAloneBoard
    extends UseCase<Board<EatingAlonePost>, GetEatingAloneBoardParams> {
  final EatingAloneRemoteRepository eatingAloneRemoteRepository;

  GetEatingAloneBoard({required this.eatingAloneRemoteRepository});

  @override
  Future<Board<EatingAlonePost>> call(GetEatingAloneBoardParams params) {
    // TODO: implement call
    return eatingAloneRemoteRepository.getBoard(
      cancelToken: params.cancelToken,
      page: params.page,
      size: 10,
      bodySize: 200,
    );
  }
}
