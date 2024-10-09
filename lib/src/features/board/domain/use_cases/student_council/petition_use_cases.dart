import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../data/repositories/student_council/petition_remote_repository.dart';
import '../../models/board.dart';
import '../../models/post_sort.dart';
import '../../models/student_council/petition_post.dart';
import '../../models/student_council/petition_status.dart';
import '../board_use_cases.dart';

final petitionUseCasesProvider = Provider.autoDispose<PetitionUseCases>(
  (ref) => PetitionUseCases(
    petitionRemoteRepository: ref.watch(petitionRemoteRepositoryProvider),
  ),
);

class PetitionUseCases extends BoardUseCases<PetitionPost> {
  final PetitionRemoteRepository petitionRemoteRepository;

  PetitionUseCases({
    required this.petitionRemoteRepository,
  });

  @override
  Future<Board<PetitionPost>> getBoard({
    CancelToken? cancelToken,
    required int page,
    List<PostSort>? sort,
    PetitionStatus status = PetitionStatus.active,
  }) {
    // TODO: implement getBoard
    return petitionRemoteRepository.getBoard(
      cancelToken: cancelToken,
      page: page,
      size: defaultSize,
      bodySize: defaultBodySize,
      sort: (sort ?? defaultSort).map((e) => e.toString()).toList(),
      status: status.value,
    );
  }

  @override
  Future<PetitionPost> getPost({
    CancelToken? cancelToken,
    required int id,
  }) {
    // TODO: implement getPost
    return petitionRemoteRepository.getPost(
      cancelToken: cancelToken,
      id: id,
    );
  }

  Future<bool> agreePost({
    required int id,
  }) {
    return petitionRemoteRepository.agreePost(
      id: id,
    );
  }

  Future<int> addPost({
    required String title,
    required String body,
    required List<String> images,
    required List<String> files,
  }) {
    return petitionRemoteRepository.addPost(
      title: title,
      body: body,
      images: images,
      files: files,
    );
  }
}
