import 'package:dio/dio.dart';
import 'package:http_parser/http_parser.dart';
import 'package:mime_type/mime_type.dart';

import '../../../../core/services/network/network_client_service.dart';
import '../../../../core/utils/remote_data_source.dart';
import '../dto/coalition_board_dto.dart';
import '../dto/coalition_post_dto.dart';
import '../dto/notice_board_dto.dart';
import '../dto/notice_post_dto.dart';
import '../dto/petition_board_dto.dart';
import '../dto/petition_post_dto.dart';
import '../dto/search_result_dto.dart';

class PetitionRemoteDataSource extends RemoteDataSource {
  PetitionRemoteDataSource({required super.networkClientService});

  Future<SearchResultDTO> searchPost({
    CancelToken? cancelToken,
    String? keyword,
    int? page,
    int? size,
    int? bodySize,
  }) async {
    return request(
      path: '/post/search',
      method: RequestType.get,
      queryParameters: {
        'keyword': keyword,
        'page': page,
        'size': size,
        'bodySize': bodySize,
      },
      cancelToken: cancelToken,
      fromJson: SearchResultDTO.fromJson,
    );
  }

  Future<NoticeBoardDTO> getNoticeBoard({
    CancelToken? cancelToken,
    String? keyword,
    int? bodySize,
    int? page,
    int? size,
    required List<String>? sort,
  }) async {
    return request(
      path: '/post/notice',
      method: RequestType.get,
      queryParameters: {
        'keyword': keyword,
        'page': page,
        'bodySize': bodySize,
        'size': size,
        'sort': sort?.map((e) => e).join('&'),
      },
      cancelToken: cancelToken,
      fromJson: NoticeBoardDTO.fromJson,
    );
  }

  Future<NoticePostDTO> getNoticePost({
    CancelToken? cancelToken,
    int? id,
  }) async {
    return request(
      path: '/post/notice/$id',
      method: RequestType.get,
      cancelToken: cancelToken,
      fromJson: NoticePostDTO.fromJson,
    );
  }

  Future<CoalitionBoardDTO> getCoalitionBoard({
    CancelToken? cancelToken,
    String? coalitionType,
    int? bodySize,
    int? page,
    int? size,
    required List<String>? sort,
  }) async {
    return request(
      path: '/post/coalition',
      method: RequestType.get,
      queryParameters: {
        'coalitionType': coalitionType,
        'page': page,
        'bodySize': bodySize,
        'size': size,
        'sort': sort?.map((e) => e).join('&'),
      },
      cancelToken: cancelToken,
      fromJson: CoalitionBoardDTO.fromJson,
    );
  }

  Future<CoalitionPostDTO> getCoalitionPost({
    CancelToken? cancelToken,
    int? id,
  }) async {
    return request(
      path: '/post/coalition/$id',
      method: RequestType.get,
      cancelToken: cancelToken,
      fromJson: CoalitionPostDTO.fromJson,
    );
  }

  Future<PetitionBoardDTO> getPetitionBoard({
    CancelToken? cancelToken,
    required String status,
    String? keyword,
    int? bodySize,
    int? page,
    int? size,
    required List<String>? sort,
  }) async {
    return request(
      path: '/post/petition',
      method: RequestType.get,
      queryParameters: {
        'keyword': keyword,
        'status': status,
        'bodySize': bodySize,
        'page': page,
        'size': size,
        'sort': sort?.map((e) => e).join('&'),
      },
      cancelToken: cancelToken,
      fromJson: PetitionBoardDTO.fromJson,
    );
  }

  Future<PetitionPostDTO> getPetitionPost({
    CancelToken? cancelToken,
    int? id,
  }) async {
    return request(
      path: '/post/petition/$id',
      method: RequestType.get,
      cancelToken: cancelToken,
      fromJson: PetitionPostDTO.fromJson,
    );
  }

  Future<bool> agreePetition({
    CancelToken? cancelToken,
    required int id,
  }) async {
    return request(
      path: '/post/petition/agree/$id',
      method: RequestType.post,
      cancelToken: cancelToken,
      fromJson: (_) => true,
    );
  }

  Future<bool> writePetition({
    CancelToken? cancelToken,
    required String title,
    required String body,
    required List<String> images,
    required List<String> files,
  }) async {
    return request(
      path: '/post/petition',
      method: RequestType.post,
      headers: {
        'Content-Type': 'multipart/form-data',
      },
      data: FormData.fromMap({
        'title': title,
        'body': body,
        if (images.isNotEmpty)
          'images': images
              .map(
                (e) => MultipartFile.fromFileSync(
                  e,
                  filename: e.split('/').last,
                  contentType:
                      MediaType.parse(mime(e) ?? 'application/octet-stream'),
                ),
              )
              .toList(),
        if (files.isNotEmpty)
          'files': files
              .map(
                (e) => MultipartFile.fromFileSync(
                  e,
                  filename: e.split('/').last,
                  contentType:
                      MediaType.parse(mime(e) ?? 'application/octet-stream'),
                ),
              )
              .toList(),
      }),
      cancelToken: cancelToken,
      fromJson: (_) => true,
    );
  }

  Future<bool> reportPost({
    required int id,
    required String type,
  }) async {
    return request(
      path: '/report/$id',
      method: RequestType.post,
      data: {
        'categoryName': type,
      },
      fromJson: (_) => true,
    );
  }
}
