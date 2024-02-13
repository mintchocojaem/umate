import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../utils/utils.dart';
import '../../../features.dart';

final busRemoteApiProvider = Provider.autoDispose<BusRemoteApi>((ref) {
  return BusRemoteApi(
    dioClient: ref.watch(dioClientProvider),
  );
});

class BusRemoteApi {
  final DioClient dioClient;

  BusRemoteApi({required this.dioClient});

  Future<BusArrivalInfoModel> getBusArrivalInfo() async {
    final response = await dioClient.request(
      method: RequestType.get,
      path: '/bus',
    );

    return BusArrivalInfoModel.fromJson(response.data);
  }
}
