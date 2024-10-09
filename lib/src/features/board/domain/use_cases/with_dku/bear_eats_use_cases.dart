import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../data/repositories/with_dku/bear_eats_remote_repository.dart';
import '../../models/board.dart';
import '../../models/post_sort.dart';
import '../../models/with_dku/bear_eats_post.dart';
import '../board_use_cases.dart';

final bearEatsUseCasesProvider = Provider.autoDispose<BearEatsUseCases>(
  (ref) => BearEatsUseCases(
    bearEatsRemoteRepository: ref.watch(bearEatsRemoteRepositoryProvider),
  ),
);

class BearEatsUseCases extends BoardUseCases {
  final BearEatsRemoteRepository bearEatsRemoteRepository;

  BearEatsUseCases({
    required this.bearEatsRemoteRepository,
  });

  @override
  Future<Board<BearEatsPost>> getBoard({
    CancelToken? cancelToken,
    required int page,
    List<PostSort>? sort,
  }) {
    // TODO: implement getBoard
    return bearEatsRemoteRepository.getBoard(
      cancelToken: cancelToken,
      page: page,
      size: defaultSize,
      bodySize: defaultBodySize,
      sort: (sort ?? defaultSort).map((e) => e.toString()).toList(),
    );
  }

  @override
  Future<BearEatsPost> getPost({CancelToken? cancelToken, required int id}) {
    // TODO: implement getPost
    return bearEatsRemoteRepository.getPost(
      cancelToken: cancelToken,
      id: id,
    );
  }
}
