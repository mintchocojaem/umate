import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/utils/use_case.dart';
import '../../data/repositories/petition_remote_repository.dart';
import '../models/board.dart';
import '../models/petition_post.dart';
import '../models/petition_status.dart';

final getPetitionBoardProvider = Provider.autoDispose
    .family<Future<Board<PetitionPost>>, GetPetitionBoardParams>(
  (ref, params) => GetPetitionBoard(
    repository: ref.watch(petitionRemoteRepositoryProvider),
  )(params),
);

class GetPetitionBoardParams extends UseCaseParams {
  final PetitionStatus status;
  final CancelToken? cancelToken;
  final int? page;

  const GetPetitionBoardParams({
    required this.status,
    this.cancelToken,
    this.page,
  });

  @override
  // TODO: implement props
  List<Object?> get props => [status, cancelToken, page];
}

class GetPetitionBoard
    extends UseCase<Board<PetitionPost>, GetPetitionBoardParams> {
  final PetitionRemoteRepository repository;

  GetPetitionBoard({required this.repository});

  @override
  Future<Board<PetitionPost>> call(GetPetitionBoardParams params) {
    // TODO: implement call
    return repository.getPetitionBoard(
      cancelToken: params.cancelToken,
      status: params.status.value,
      page: params.page,
      size: 10,
      bodySize: 200,
    );
  }
}
