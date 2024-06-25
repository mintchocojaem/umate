import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/utils/use_case.dart';
import '../../data/repositories/eating_alone_remote_repository.dart';
import '../models/eating_alone_post.dart';

final getEatingAlonePostProvider = Provider.autoDispose
    .family<Future<EatingAlonePost>, GetEatingAlonePostParams>(
  (ref, params) => GetEatingAlonePost(
    eatingAloneRemoteRepository: ref.watch(eatingAloneRemoteRepositoryProvider),
  )(params),
);

class GetEatingAlonePostParams extends UseCaseParams {
  final CancelToken? cancelToken;
  final int id;

  const GetEatingAlonePostParams({
    this.cancelToken,
    required this.id,
  });

  @override
// TODO: implement props
  List<Object?> get props => [cancelToken, id];
}

class GetEatingAlonePost
    extends UseCase<EatingAlonePost, GetEatingAlonePostParams> {
  final EatingAloneRemoteRepository eatingAloneRemoteRepository;

  GetEatingAlonePost({
    required this.eatingAloneRemoteRepository,
  });

  @override
  Future<EatingAlonePost> call(GetEatingAlonePostParams params) async {
// TODO: implement call
    return await eatingAloneRemoteRepository.getPost(
      cancelToken: params.cancelToken,
      id: params.id,
    );
  }
}
