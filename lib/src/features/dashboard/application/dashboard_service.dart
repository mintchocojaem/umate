import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../features.dart';

final dashboardProvider = Provider.autoDispose<DashboardService>(
  (ref) => DashboardService(
    petitionRepository: ref.watch(petitionRepositoryProvider),
  ),
);

class DashboardService {
  final PetitionRepository petitionRepository;

  DashboardService({
    required this.petitionRepository,
  });

  Future<PetitionBoardModel> getHomePetitionBoard() async {
    return await petitionRepository.getPetitionBoard(
      status: PetitionStatus.expired.value,
      page: 0,
      size: 5,
    );
  }

}
