import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http_parser/http_parser.dart';
import 'package:mime_type/mime_type.dart';

import '../../../../../core/services/network/network_client_service.dart';
import '../../../../../core/utils/repository.dart';
import '../../../domain/models/board.dart';
import '../../../domain/models/with_dku/dankook_trade_post.dart';

final dankookTradeRemoteRepositoryProvider = Provider.autoDispose(
  (ref) => DankookTradeRemoteRepository(
    client: ref.watch(networkClientServiceProvider),
  ),
);

class DankookTradeRemoteRepository extends RemoteRepository {
  DankookTradeRemoteRepository({required super.client});

  Future<Board<DankookTradePost>> getBoard({
    CancelToken? cancelToken,
    String? keyword,
    int? bodySize,
    int? page,
    int? size,
    List<String>? sort,
  }) async {
    final result = await client.request(
      path: '/with-dankook/trade',
      method: RequestType.get,
      queryParameters: {
        'keyword': keyword,
        'bodySize': bodySize,
        'page': page,
        'size': size,
        'sort': sort?.map((e) => e).join('&'),
      },
      cancelToken: cancelToken,
    );
    return Board.fromJson(
      result.data,
      (data) => DankookTradePost.fromJson(data as Map<String, dynamic>),
    );
  }

  Future<DankookTradePost> getPost({
    CancelToken? cancelToken,
    int? id,
  }) async {
    final result = await client.request(
      path: '/with-dankook/trade/$id',
      method: RequestType.get,
      cancelToken: cancelToken,
    );

    return DankookTradePost.fromJson(result.data);
  }

  Future<bool> addPost({
    CancelToken? cancelToken,
    required String title,
    required String price,
    required String body,
    required String tradePlace,
    required List<String> images,
    required String kakaoOpenChatLink,
  }) async {
    final result = await client.request(
      path: '/with-dankook/trade',
      method: RequestType.post,
      headers: {
        'Content-Type': 'multipart/form-data',
      },
      data: FormData.fromMap({
        'title': title,
        'body': body,
        'price': price,
        'tradePlace': tradePlace,
        'kakaoOpenChatLink': kakaoOpenChatLink,
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
      }),
      cancelToken: cancelToken,
    );
    return result.statusCode == 200;
  }

  Future<bool> deletePost({
    CancelToken? cancelToken,
    required int id,
  }) async {
    final result = await client.request(
      path: '/with-dankook/trade/$id',
      method: RequestType.delete,
      cancelToken: cancelToken,
    );
    return result.statusCode == 200;
  }

  Future<bool> closePost({
    CancelToken? cancelToken,
    required int id,
  }) async {
    final result = await client.request(
      path: '/with-dankook/trade/$id',
      method: RequestType.patch,
      cancelToken: cancelToken,
    );
    return result.statusCode == 200;
  }
}
