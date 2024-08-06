import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:umate/src/features/board/domain/models/board.dart';
import 'package:umate/src/features/board/domain/models/post.dart';

import 'package:umate/src/features/board/domain/models/post_sort.dart';
import 'package:umate/src/features/board/domain/models/student_council/search_result.dart';

import '../../../data/repositories/student_council/coalition_remote_repository.dart';
import '../../../data/repositories/student_council/search_remote_repository.dart';
import '../../models/student_council/coalition_post.dart';
import '../board_use_cases.dart';

final searchUseCasesProvider = Provider.autoDispose<SearchUseCases>(
      (ref) => SearchUseCases(
    searchRemoteRepository: ref.watch(searchRemoteRepositoryProvider),
  ),
);

class SearchUseCases{
  final SearchRemoteRepository searchRemoteRepository;

  SearchUseCases({
    required this.searchRemoteRepository,
  });

  Future<SearchResult> searchPost({
    CancelToken? cancelToken,
    required String keyword,
  }) async {
    return searchRemoteRepository.searchPost(
      cancelToken: cancelToken,
      keyword: keyword,
    );
  }

}
