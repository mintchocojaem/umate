import 'package:danvery/app/data/provider/board_provider.dart';
import 'package:danvery/app/data/repository/board_repository.dart';
import 'package:get/get.dart';
import '../controller/home_controller.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HomeController>(() => HomeController(
        boardRepository: BoardRepository(boardProvider: BoardProvider())));
  }
}
