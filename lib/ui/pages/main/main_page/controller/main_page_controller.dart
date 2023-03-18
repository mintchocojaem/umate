import 'package:get/get.dart';

class MainPageController extends GetxController{

  final RxInt _selectedIndex = 0.obs;

  int get selectedIndex => _selectedIndex.value;

  set selectedIndex(index) => _selectedIndex.value = index;

}
