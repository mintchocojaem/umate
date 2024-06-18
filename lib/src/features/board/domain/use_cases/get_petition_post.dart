import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/utils/use_case.dart';
import '../../data/repositories/petition_remote_repository.dart';
import '../models/petition_post.dart';

final getPetitionPostProvider =
    Provider.autoDispose.family<Future<PetitionPost>, GetPetitionPostParams>(
  (ref, params) => GetPetitionPost(
    petitionRemoteRepository: ref.watch(petitionRemoteRepositoryProvider),
  )(params),
);

class GetPetitionPostParams extends UseCaseParams {
  final CancelToken? cancelToken;
  final int id;

  const GetPetitionPostParams({
    this.cancelToken,
    required this.id,
  });

  @override
// TODO: implement props
  List<Object?> get props => [cancelToken, id];
}

class GetPetitionPost extends UseCase<PetitionPost, GetPetitionPostParams> {
  final PetitionRemoteRepository petitionRemoteRepository;

  GetPetitionPost({
    required this.petitionRemoteRepository,
  });

  @override
  Future<PetitionPost> call(GetPetitionPostParams params) async {
// TODO: implement call
    return await petitionRemoteRepository.getPetitionPost(
      cancelToken: params.cancelToken,
      id: params.id,
    );
  }
}
