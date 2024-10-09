import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../data/repositories/with_dku/dantudy_remote_repository.dart';
import '../../models/board.dart';
import '../../models/post_sort.dart';
import '../../models/with_dku/dantudy_post.dart';
import '../board_use_cases.dart';

final dantudyUseCasesProvider = Provider.autoDispose<DantudyUseCases>(
  (ref) => DantudyUseCases(
    dantudyRemoteRepository: ref.watch(dantudyRemoteRepositoryProvider),
  ),
);

class DantudyUseCases extends BoardUseCases {
  final DantudyRemoteRepository dantudyRemoteRepository;

  DantudyUseCases({
    required this.dantudyRemoteRepository,
  });

  @override
  Future<Board<DantudyPost>> getBoard({
    CancelToken? cancelToken,
    required int page,
    List<PostSort>? sort,
  }) {
    // TODO: implement getBoard
    return dantudyRemoteRepository.getBoard(
      cancelToken: cancelToken,
      page: page,
      size: defaultSize,
      bodySize: defaultBodySize,
      sort: (sort ?? defaultSort).map((e) => e.toString()).toList(),
    );
  }

  @override
  Future<DantudyPost> getPost({CancelToken? cancelToken, required int id}) {
    // TODO: implement getPost
    return dantudyRemoteRepository.getPost(
      cancelToken: cancelToken,
      id: id,
    );
  }

  Future<bool> addPost({
    required String title,
    required String body,
    required int minStudentId,
    required String tag,
    required String startTime,
    required String endTime,
  }) async {
    return dantudyRemoteRepository.addPost(
      title: title,
      body: body,
      minStudentId: minStudentId,
      tag: tag,
      startTime: startTime.toString(),
      endTime: endTime.toString(),
    );
  }
}
