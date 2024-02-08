import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../features.dart';

final dashboardProvider = Provider.autoDispose<DashboardService>(
  (ref) => DashboardService(
    petitionRepository: ref.watch(petitionRepositoryProvider),
    busRepository: ref.watch(busRepositoryProvider),
  ),
);

class DashboardService {
  final PetitionRepository petitionRepository;
  final BusRepository busRepository;

  DashboardService({
    required this.petitionRepository,
    required this.busRepository,
  });

  Future<PetitionBoardModel> getHomePetitionBoard() async {
    return await petitionRepository.getPetitionBoard(
      status: PetitionStatus.expired.value,
      page: 0,
      size: 4,
    );
  }

  Future<BusArrivalInfoModel> getHomeBusArrivalInfo() async {
    return await busRepository.getBusArrivalInfo();
  }

}
