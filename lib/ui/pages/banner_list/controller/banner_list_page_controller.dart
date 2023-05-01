import 'package:danvery/domain/banner/model/banner_list_model.dart';
import 'package:danvery/domain/banner/model/banner_model.dart';
import 'package:danvery/ui/pages/main/home_page/controller/home_page_controller.dart';
import 'package:get/get.dart';

class BannerListPageController extends GetxController{

  final HomePageController homePageController = Get.find();

  late final BannerListModel bannerListModel;

  BannerModel? bannerModel;

  RxBool isLoadBannerModel = false.obs;

  late int currentBannerIndex;


  @override
  void onInit() {
    bannerListModel = homePageController.bannerList.value;
    currentBannerIndex = homePageController.currentBannerIndex.value;
    if(Get.arguments != null) setBannerModel(Get.arguments);
    super.onInit();
  }

  void setBannerModel(BannerModel newBannerModel){
    isLoadBannerModel.value = false;
    bannerModel = newBannerModel;
    isLoadBannerModel.value = true;
  }
}
