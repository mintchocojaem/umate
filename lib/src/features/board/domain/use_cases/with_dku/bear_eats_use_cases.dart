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

  @override
  Future<bool> deletePost({
    CancelToken? cancelToken,
    required int id,
  }) {
    return bearEatsRemoteRepository.deletePost(
      cancelToken: cancelToken,
      id: id,
    );
  }

  Future<bool> addPost({
    CancelToken? cancelToken,
    required String title,
    required String restaurant,
    required String deliveryPlace,
    required String deliveryTime,
    required String body,
  }) async {
    return bearEatsRemoteRepository.addPost(
      cancelToken: cancelToken,
      title: title,
      restaurant: restaurant,
      deliveryPlace: deliveryPlace,
      deliveryTime: deliveryTime,
      body: body,
    );
  }

  Future<bool> enterPost({
    CancelToken? cancelToken,
    required int id,
  }) async {
    return bearEatsRemoteRepository.enterPost(
      cancelToken: cancelToken,
      id: id,
    );
  }

  Future<bool> closePost({
    CancelToken? cancelToken,
    required int id,
  }) async {
    return bearEatsRemoteRepository.closePost(
      cancelToken: cancelToken,
      id: id,
    );
  }
}
