import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http_parser/http_parser.dart';
import 'package:mime_type/mime_type.dart';

import '../../../../core/services/network/network_client_service.dart';
import '../../../../core/utils/repository.dart';
import '../../domain/models/board.dart';
import '../../domain/models/petition_post.dart';

final petitionRemoteRepositoryProvider =
    Provider.autoDispose<PetitionRemoteRepository>(
  (ref) => PetitionRemoteRepository(
    networkClientService: ref.watch(networkClientServiceProvider),
  ),
);

class PetitionRemoteRepository extends RemoteRepository {
  PetitionRemoteRepository({required super.networkClientService});

  Future<Board<PetitionPost>> getBoard({
    CancelToken? cancelToken,
    required String status,
    String? keyword,
    int? bodySize,
    int? page,
    int? size,
    List<String>? sort,
  }) async {
    final result = await networkClientService.request(
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
    );
    return Board.fromJson(
      result.data,
      (data) => PetitionPost.fromJson(data as Map<String, dynamic>),
    );
  }

  Future<PetitionPost> getPost({
    CancelToken? cancelToken,
    int? id,
  }) async {
    final result = await networkClientService.request(
      path: '/post/petition/$id',
      method: RequestType.get,
      cancelToken: cancelToken,
    );
    return PetitionPost.fromJson(result.data);
  }

  Future<bool> agreePetition({
    CancelToken? cancelToken,
    required int id,
  }) async {
    final result = await networkClientService.request(
      path: '/post/petition/agree/$id',
      method: RequestType.post,
      cancelToken: cancelToken,
    );
    return result.statusCode == 200;
  }

  Future<bool> writePost({
    CancelToken? cancelToken,
    required String title,
    required String body,
    required List<String> images,
    required List<String> files,
  }) async {
    final result = await networkClientService.request(
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
    );
    return result.statusCode == 200;
  }
}
