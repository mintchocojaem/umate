import 'package:get/get.dart';

class MainController extends GetxController{

  static MainController get to => Get.find();

  final RxInt _selectedIndex = 0.obs;

  int get selectedIndex => _selectedIndex.value;

  set selectedIndex(index) => _selectedIndex.value = index;

}
