import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/utils/use_case.dart';
import '../../data/repository/petition_repository.dart';
import '../model/petition_board.dart';
import '../model/petition_status.dart';

final getPetitionBoardProvider = Provider.autoDispose<GetPetitionBoard>(
  (ref) => GetPetitionBoard(repository: ref.watch(petitionRepositoryProvider)),
);

class GetPetitionBoardParams extends UseCaseParams {
  final PetitionStatus status;
  final CancelToken? cancelToken;
  final int? page;

  GetPetitionBoardParams({
    required this.status,
    this.cancelToken,
    this.page,
  });
}

class GetPetitionBoard extends UseCase<PetitionBoard, GetPetitionBoardParams> {
  final PetitionRepository repository;

  GetPetitionBoard({required this.repository});

  @override
  Future<PetitionBoard> execute(GetPetitionBoardParams params) async {
    // TODO: implement execute
    return repository.getPetitionBoard(
      cancelToken: params.cancelToken,
      status: params.status.value,
      page: params.page,
      size: 10,
    );
  }
}
