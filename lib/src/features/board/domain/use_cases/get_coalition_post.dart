import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/utils/use_case.dart';
import '../../data/repositories/coalition_remote_repository.dart';
import '../models/coalition_post.dart';

final getCoalitionPostProvider =
    Provider.autoDispose.family<Future<CoalitionPost>, GetCoalitionPostParams>(
  (ref, params) => GetCoalitionPost(
    coalitionRemoteRepository: ref.watch(coalitionRemoteRepositoryProvider),
  )(params),
);

class GetCoalitionPostParams extends UseCaseParams {
  final CancelToken? cancelToken;
  final int id;

  const GetCoalitionPostParams({
    this.cancelToken,
    required this.id,
  });

  @override
// TODO: implement props
  List<Object?> get props => [cancelToken, id];
}

class GetCoalitionPost extends UseCase<CoalitionPost, GetCoalitionPostParams> {
  final CoalitionRemoteRepository coalitionRemoteRepository;

  GetCoalitionPost({
    required this.coalitionRemoteRepository,
  });

  @override
  Future<CoalitionPost> call(GetCoalitionPostParams params) async {
// TODO: implement call
    return await coalitionRemoteRepository.getPost(
      cancelToken: params.cancelToken,
      id: params.id,
    );
  }
}
