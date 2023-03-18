import 'package:get/get.dart';

import '../../../../../domain/auth/login/services/login_service.dart';
import '../../../../../domain/board/petition/controller/petition_controller.dart';
import '../../../../../domain/board/petition/controller/post_controller.dart';
import '../../../../../domain/bus/controller/bus_controller.dart';
import '../../../../widgets/board/board_card.dart';

class HomePageController extends GetxController{

  final PostController postController = Get.find<PostController>();
  final PetitionController petitionController = Get.find<PetitionController>();
  final LoginService loginService = Get.find<LoginService>();
  final BusController busController = Get.find<BusController>();

  List<BoardCard> getBoardList(dynamic data) {
    List<BoardCard> result = [];
    for (dynamic i in data) {
      result.add(BoardCard(leadingText: "익명", title: i.title));
    }
    return result;
  }

}
