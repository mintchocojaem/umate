import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../utils/utils.dart';
import '../../../features.dart';

final petitionRepositoryProvider = Provider.autoDispose<PetitionRepository>((ref) {
  return PetitionRepository(
    petitionApi: PetitionApi(dioClient: ref.watch(dioClientProvider)),
  );
});

class PetitionRepository {
  final PetitionApi petitionApi;

  PetitionRepository({required this.petitionApi});

  Future<PetitionBoardModel> getPetitionBoard({
    String? keyword,
    required int page,
    int? bodySize,
    required int size,
    required String status,
  }) async {
    return await petitionApi.getPetitionBoard(
      keyword: keyword,
      page: page,
      bodySize: bodySize,
      size: size,
      status: status,
    );
  }
}