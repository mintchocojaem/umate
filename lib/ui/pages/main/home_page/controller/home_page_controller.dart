import 'package:get/get.dart';

import '../../../../../domain/auth/login/service/login_service.dart';
import '../../../../../domain/board/petition/controller/petition_controller.dart';
import '../../../../../domain/board/post/controller/post_controller.dart';
import '../../../../../domain/bus/controller/bus_controller.dart';

class HomePageController extends GetxController{

  final PostController postController = Get.find<PostController>();
  final PetitionController petitionController = Get.find<PetitionController>();
  final LoginService loginService = Get.find<LoginService>();
  final BusController busController = Get.find<BusController>();

}
