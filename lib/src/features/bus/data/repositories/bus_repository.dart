import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../features.dart';

final busRepositoryProvider = Provider.autoDispose<BusRepository>(
  (ref) {
    final busApiClient = ref.watch(busRemoteApiProvider);
    return BusRepository(busApi: busApiClient);
  },
);

class BusRepository {
  final BusRemoteApi busApi;

  BusRepository({required this.busApi});

  Future<BusArrivalInfoModel> getBusArrivalInfo() async {
    final busArrivalInfo = await busApi.getBusArrivalInfo();
    return busArrivalInfo;
  }
}