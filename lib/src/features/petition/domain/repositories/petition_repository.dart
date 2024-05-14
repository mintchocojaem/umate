import 'package:dio/dio.dart';

import '../models/board.dart';
import '../models/coalition_post.dart';
import '../models/coalition_type.dart';
import '../models/notice_post.dart';
import '../models/petition_post.dart';
import '../models/petition_status.dart';
import '../models/post_report_type.dart';
import '../models/search_result.dart';
import '../models/post_sort.dart';

abstract class PetitionRepository {

  Future<SearchResult> searchPost({
    CancelToken? cancelToken,
    String? keyword,
    int? page,
    int? size,
    int? bodySize,
  });

  Future<Board<NoticePost>> getNoticeBoard({
    CancelToken? cancelToken,
    int? bodySize,
    int? page,
    int? size,
    required List<PostSort>? sort,
  });

  Future<NoticePost> getNoticePost({
    CancelToken? cancelToken,
    required int id,
  });

  Future<Board<CoalitionPost>> getCoalitionBoard({
    CancelToken? cancelToken,
    required CoalitionType coalitionType,
    int? bodySize,
    int? page,
    int? size,
    required List<PostSort>? sort,
  });

  Future<CoalitionPost> getCoalitionPost({
    CancelToken? cancelToken,
    required int id,
  });

  Future<Board<PetitionPost>> getPetitionBoard({
    CancelToken? cancelToken,
    required PetitionStatus status,
    String? keyword,
    int? bodySize,
    int? page,
    int? size,
    required List<PostSort>? sort,
  });

  Future<PetitionPost> getPetitionPost({
    CancelToken? cancelToken,
    required int id,
  });

  Future<bool> agreePetition({
    CancelToken? cancelToken,
    required int id,
  });

  Future<bool> writePetition({
    CancelToken? cancelToken,
    required String title,
    required String body,
    required List<String> images,
    required List<String> files,
  });

  Future<bool> reportPost({
    required int id,
    required PostReportType type,
  });

}