import 'package:dio/dio.dart';
import 'package:umate/src/features/petition/domain/models/post_report_type.dart';

import '../../domain/models/board.dart';
import '../../domain/models/coalition_post.dart';
import '../../domain/models/coalition_type.dart';
import '../../domain/models/notice_post.dart';
import '../../domain/models/petition_post.dart';
import '../../domain/models/petition_status.dart';
import '../../domain/models/search_result.dart';
import '../../domain/models/post_sort.dart';
import '../../domain/repositories/petition_repository.dart';
import '../data_sources/petition_remote_data_source.dart';

class PetitionRepositoryImpl implements PetitionRepository {
  final PetitionRemoteDataSource petitionRemoteDataSource;

  PetitionRepositoryImpl({
    required this.petitionRemoteDataSource,
  });

  @override
  Future<SearchResult> searchPost({
    CancelToken? cancelToken,
    String? keyword,
    int? page,
    int? size,
    String? sort,
    int? bodySize,
  }) async {
    final response = await petitionRemoteDataSource.searchPost(
      cancelToken: cancelToken,
      keyword: keyword,
      page: page,
      size: size,
      bodySize: bodySize,
    );
    return response.mapToModel();
  }

  @override
  Future<Board<NoticePost>> getNoticeBoard({
    CancelToken? cancelToken,
    int? bodySize,
    int? page,
    int? size,
    required List<PostSort>? sort,
  }) async {
    final response = await petitionRemoteDataSource.getNoticeBoard(
      cancelToken: cancelToken,
      bodySize: bodySize,
      page: page,
      size: size,
      sort: sort?.map((e) => e.toString()).toList(),
    );
    return response.mapToModel();
  }

  @override
  Future<NoticePost> getNoticePost({
    CancelToken? cancelToken,
    required int id,
  }) async {
    // TODO: implement getNoticePost
    final response = await petitionRemoteDataSource.getNoticePost(
      cancelToken: cancelToken,
      id: id,
    );
    return response.mapToModel();
  }

  @override
  Future<Board<CoalitionPost>> getCoalitionBoard({
    CancelToken? cancelToken,
    required CoalitionType coalitionType,
    int? bodySize,
    int? page,
    int? size,
    required List<PostSort>? sort,
  }) async {
    final response = await petitionRemoteDataSource.getCoalitionBoard(
      cancelToken: cancelToken,
      coalitionType: coalitionType.value,
      bodySize: bodySize,
      page: page,
      size: size,
      sort: sort?.map((e) => e.toString()).toList(),
    );
    return response.mapToModel();
  }

  @override
  Future<CoalitionPost> getCoalitionPost({
    CancelToken? cancelToken,
    required int id,
  }) async {
    // TODO: implement getCoalitionPost
    final response = await petitionRemoteDataSource.getCoalitionPost(
      cancelToken: cancelToken,
      id: id,
    );
    return response.mapToModel();
  }

  @override
  Future<Board<PetitionPost>> getPetitionBoard({
    CancelToken? cancelToken,
    required PetitionStatus status,
    String? keyword,
    int? bodySize,
    int? page,
    int? size,
    required List<PostSort>? sort,
  }) async {
    final response = await petitionRemoteDataSource.getPetitionBoard(
      cancelToken: cancelToken,
      keyword: keyword,
      status: status.value,
      bodySize: bodySize,
      page: page,
      size: size,
      sort: sort?.map((e) => e.toString()).toList(),
    );
    return response.mapToModel();
  }

  @override
  Future<PetitionPost> getPetitionPost({
    CancelToken? cancelToken,
    required int id,
  }) async {
    final response = await petitionRemoteDataSource.getPetitionPost(
      cancelToken: cancelToken,
      id: id,
    );
    return response.mapToModel();
  }

  @override
  Future<bool> agreePetition({
    CancelToken? cancelToken,
    required int id,
  }) async {
    final response = await petitionRemoteDataSource.agreePetition(
      cancelToken: cancelToken,
      id: id,
    );
    return response;
  }

  @override
  Future<bool> writePetition({
    CancelToken? cancelToken,
    required String title,
    required String body,
    required List<String> images,
    required List<String> files,
  }) {
    // TODO: implement writePetitionPost
    return petitionRemoteDataSource.writePetition(
      cancelToken: cancelToken,
      title: title,
      body: body,
      images: images,
      files: files,
    );
  }

  @override
  Future<bool> reportPost({
    required int id,
    required PostReportType type,
  }) {
    // TODO: implement reportPost
    return petitionRemoteDataSource.reportPost(
      id: id,
      type: type.value,
    );
  }
}
