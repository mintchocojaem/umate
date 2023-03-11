import 'package:danvery/app/data/model/bus_model.dart';
import 'package:danvery/app/data/repository/bus_repository.dart';
import 'package:get/get.dart';

class BusController extends GetxController {

  final BusRepository busRepository;

  BusController({required this.busRepository});

  final RxList<BusModel> busListOfJungMoon = <BusModel>[].obs;
  final RxBool _isLoadBustList = false.obs;

  bool get isLoadBusList => _isLoadBustList.value;

  void getBustList(){
    busRepository.getBusListFromStation("단국대정문").then((value) {
      if (value != null) {
        busListOfJungMoon.value = value;
        _isLoadBustList.value = true;
        /*
        busRepository.getBusListFromStation("곰상").then((value) {
          if(value != null){
            _isLoadBustList.value = true;
          }
        });

         */
      }
    });
  }


  void refreshBusList(){
    getBustList();
  }

}
