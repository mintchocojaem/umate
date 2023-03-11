import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

class BoardPageController extends GetxController{

  final RxInt _selectedTap = 0.obs;

  int get selectedTap => _selectedTap.value;

  set selectedTap(index) => _selectedTap.value = index;

}
