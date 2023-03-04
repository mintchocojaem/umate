import 'package:danvery/app/data/repository/board_repository.dart';
import 'package:get/get.dart';

import '../controller/board_controller.dart';
import '../data/provider/board_provider.dart';

class BoardBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<BoardController>(() => BoardController(boardRepository: BoardRepository(boardProvider: BoardProvider())));
  }
}
