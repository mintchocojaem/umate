import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/utils/use_case.dart';
import '../../data/repositories/coalition_remote_repository.dart';
import '../models/board.dart';
import '../models/coalition_post.dart';
import '../models/coalition_type.dart';

final getCoalitionBoardProvider = Provider.autoDispose
    .family<Future<Board<CoalitionPost>>, GetCoalitionBoardParams>(
  (ref, params) => GetCoalitionBoard(
    repository: ref.watch(coalitionRemoteRepositoryProvider),
  )(params),
);

class GetCoalitionBoardParams extends UseCaseParams {
  final CoalitionType type;
  final CancelToken? cancelToken;
  final int? page;

  const GetCoalitionBoardParams({
    required this.type,
    this.cancelToken,
    this.page,
  });

  @override
  // TODO: implement props
  List<Object?> get props => [type, cancelToken, page];
}

class GetCoalitionBoard
    extends UseCase<Board<CoalitionPost>, GetCoalitionBoardParams> {
  final CoalitionRemoteRepository repository;

  GetCoalitionBoard({required this.repository});

  @override
  Future<Board<CoalitionPost>> call(GetCoalitionBoardParams params) {
    // TODO: implement call
    return repository.getBoard(
      cancelToken: params.cancelToken,
      coalitionType: params.type.value,
      page: params.page,
      size: 10,
      bodySize: 200,
    );
  }
}
