import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/utils/use_case.dart';
import '../../data/repositories/petition_remote_repository.dart';

final agreePetitionPostProvider =
    Provider.autoDispose.family<Future<bool>, AgreePetitionPostParams>(
  (ref, params) => AgreePetitionPost(
    petitionRemoteRepository: ref.read(petitionRemoteRepositoryProvider),
  )(params),
);

class AgreePetitionPostParams extends UseCaseParams {
  final CancelToken? cancelToken;
  final int id;

  const AgreePetitionPostParams({
    this.cancelToken,
    required this.id,
  });

  @override
  // TODO: implement props
  List<Object?> get props => [cancelToken, id];
}

class AgreePetitionPost extends UseCase<bool, AgreePetitionPostParams> {
  final PetitionRemoteRepository petitionRemoteRepository;

  AgreePetitionPost({
    required this.petitionRemoteRepository,
  });

  @override
  Future<bool> call(AgreePetitionPostParams params) async {
    // TODO: implement call
    return await petitionRemoteRepository.agreePetition(
      id: params.id,
    );
  }
}
