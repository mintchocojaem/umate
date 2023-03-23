import 'package:danvery/domain/auth/login/service/login_service.dart';
import 'package:danvery/domain/board/general_post/controller/general_post_controller.dart';
import 'package:danvery/domain/board/petition_post/controller/petition_post_controller.dart';
import 'package:danvery/domain/bus/controller/bus_controller.dart';
import 'package:get/get.dart';

class HomePageController extends GetxController{

  final GeneralPostController postController = Get.find<GeneralPostController>();
  final PetitionController petitionController = Get.find<PetitionController>();
  final LoginService loginService = Get.find<LoginService>();
  final BusController busController = Get.find<BusController>();

}
