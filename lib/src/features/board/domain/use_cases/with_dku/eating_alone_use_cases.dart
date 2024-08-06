import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../data/repositories/with_dku/eating_alone_remote_repository.dart';
import '../../models/board.dart';
import '../../models/post_sort.dart';
import '../../models/with_dku/eating_alone_post.dart';
import '../board_use_cases.dart';

final eatingAloneUseCasesProvider =
    Provider.autoDispose<EatingAloneUseCases>(
  (ref) => EatingAloneUseCases(
    eatingAloneRemoteRepository: ref.watch(eatingAloneRemoteRepositoryProvider),
  ),
);

class EatingAloneUseCases extends BoardUseCases {
  final EatingAloneRemoteRepository eatingAloneRemoteRepository;

  EatingAloneUseCases({
    required this.eatingAloneRemoteRepository,
  });

  @override
  Future<Board<EatingAlonePost>> getBoard({
    CancelToken? cancelToken,
    required int page,
    List<PostSort>? sort,
  }) {
    // TODO: implement getBoard
    return eatingAloneRemoteRepository.getBoard(
      cancelToken: cancelToken,
      page: page,
      size: defaultSize,
      bodySize: defaultBodySize,
      sort: (sort ?? defaultSort).map((e) => e.toString()).toList(),
    );
  }

  @override
  Future<EatingAlonePost> getPost({CancelToken? cancelToken, required int id}) {
    // TODO: implement getPost
    throw UnimplementedError();
  }
}
