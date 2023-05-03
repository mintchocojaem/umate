import 'package:danvery/domain/banner/model/banner_list_model.dart';
import 'package:danvery/domain/banner/model/banner_model.dart';
import 'package:danvery/ui/pages/main/home_page/controller/home_page_controller.dart';
import 'package:get/get.dart';

class BannerPageController extends GetxController{

  final HomePageController homePageController = Get.find();

  late final BannerListModel bannerListModel;

  BannerModel? bannerModel;

  late int currentBannerIndex;

  @override
  void onInit() {
    bannerListModel = homePageController.bannerList.value;
    currentBannerIndex = homePageController.currentBannerIndex.value;
    if(Get.arguments != null) bannerModel = Get.arguments;
    super.onInit();
  }

}
