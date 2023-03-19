import 'package:danvery/utils/interceptor/dio_interceptor.dart';
import 'package:get/get.dart';

import '../controller/bus_controller.dart';
import '../provider/bus_provider.dart';
import '../repository/bus_repository.dart';

class BusBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<BusController>(() => BusController(
        busRepository: BusRepository(
            busProvider: BusProvider(dio: DioInterceptor().dio))));
  }
}
