import 'package:danvery/app/controller/bus_controller.dart';
import 'package:danvery/app/data/provider/bus_provider.dart';
import 'package:danvery/app/data/repository/bus_repository.dart';
import 'package:get/get.dart';

class BusBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<BusController>(() => BusController(busRepository: BusRepository(busProvider: BusProvider())));
  }
}
