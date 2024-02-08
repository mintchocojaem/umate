import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../utils/utils.dart';
import '../../../features.dart';

final busApiProvider = Provider.autoDispose<BusApi>((ref) {
  return BusApi(
    dioClient: ref.watch(dioClientProvider),
  );
});

class BusApi {
  final DioClient dioClient;

  BusApi({required this.dioClient});

  Future<BusArrivalInfoModel> getBusArrivalInfo() async {
    final response = await dioClient.request(
      method: RequestType.get,
      path: '/bus',
    );

    return BusArrivalInfoModel.fromJson(response.data);
  }
}
