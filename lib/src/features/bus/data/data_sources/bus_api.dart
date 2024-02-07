import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../utils/utils.dart';

final busApiProvider = Provider.autoDispose<BusApi>((ref) {
  return BusApi(
    dioClient: ref.watch(dioClientProvider),
  );
});

class BusApi{

  final DioClient dioClient;

  BusApi({required this.dioClient});

  

}