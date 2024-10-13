import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:umate/src/features/board/domain/models/board.dart';
import 'package:umate/src/features/board/domain/models/post_sort.dart';

import '../../../data/repositories/student_council/coalition_remote_repository.dart';
import '../../models/student_council/coalition_post.dart';
import '../../models/student_council/coalition_type.dart';
import '../board_use_cases.dart';

final coalitionUseCasesProvider = Provider.autoDispose<CoalitionUseCases>(
  (ref) => CoalitionUseCases(
    coalitionRemoteRepository: ref.watch(coalitionRemoteRepositoryProvider),
  ),
);

class CoalitionUseCases extends BoardUseCases {
  final CoalitionRemoteRepository coalitionRemoteRepository;

  CoalitionUseCases({
    required this.coalitionRemoteRepository,
  });

  @override
  Future<Board<CoalitionPost>> getBoard({
    CancelToken? cancelToken,
    required int page,
    List<PostSort>? sort,
    CoalitionType? type,
  }) {
    // TODO: implement getBoard
    return coalitionRemoteRepository.getBoard(
      cancelToken: cancelToken,
      page: page,
      size: defaultSize,
      bodySize: defaultBodySize,
      sort: (sort ?? defaultSort).map((e) => e.toString()).toList(),
      coalitionType: (type ?? CoalitionType.food).value,
    );
  }

  @override
  Future<CoalitionPost> getPost({
    CancelToken? cancelToken,
    required int id,
  }) {
    // TODO: implement getPost
    return coalitionRemoteRepository.getPost(
      cancelToken: cancelToken,
      id: id,
    );
  }

  @override
  Future<bool> deletePost({
    CancelToken? cancelToken,
    required int id,
  }) {
    return coalitionRemoteRepository.deletePost(
      cancelToken: cancelToken,
      id: id,
    );
  }
}
