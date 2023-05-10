import 'package:danvery/core/dto/api_response_dto.dart';
import 'package:danvery/domain/check_update/model/check_update_model.dart';
import 'package:danvery/domain/check_update/repository/check_update_repository.dart';
import 'package:danvery/routes/app_routes.dart';
import 'package:danvery/service/login/login_service.dart';
import 'package:danvery/ui/widgets/getx_snackbar/getx_snackbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:store_redirect/store_redirect.dart';

class SplashScreenPageController extends GetxController
    with GetSingleTickerProviderStateMixin {
  final CheckUpdateRepository updateCheckRepository = CheckUpdateRepository();
  final LoginService loginService = Get.find<LoginService>();

  late AnimationController animationController;
  late Animation<double> animation;

  @override
  onInit() async {
    await animationInit();
    super.onInit();
  }

  Future<void> animationInit() async {
    animationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 1000));
    animation =
        CurvedAnimation(parent: animationController, curve: Curves.easeOut)
            .obs
            .value;
    animation.addListener(() => update());
    await animationController.forward();
    await checkUpdate();
  }

  Future<void> checkUpdate() async {
    final GetStorage box = GetStorage();
    final String? accessToken = box.read("accessToken");
    final String? refreshToken = box.read("refreshToken");

    final ApiResponseDTO apiResponseDTO =
        await updateCheckRepository.checkUpdate();
    if (apiResponseDTO.success) {
      PackageInfo packageInfo = await PackageInfo.fromPlatform();
      CheckUpdateModel checkUpdateModel =
          apiResponseDTO.data as CheckUpdateModel;
      if (checkUpdateModel.minVersion != packageInfo.version) {
        showCupertinoDialog(
            context: Get.context!,
            builder: (BuildContext context) {
              return CupertinoAlertDialog(
                title: const Text("Danvery 업데이트 안내"),
                content: const Text("최신 버전 앱으로 업데이트를 위해\n스토어로 이동합니다."),
                actions: [
                  CupertinoDialogAction(
                    child: const Text("확인"),
                    onPressed: () async {
                      try {
                        await StoreRedirect.redirect(
                          androidAppId: "com.vanillajaem.danvery",
                          iOSAppId: "6448884101",
                        );
                      } catch (e) {
                        GetXSnackBar(
                                type: GetXSnackBarType.customError,
                                title: "Oops!",
                                content: "스토어로 이동할 수 없습니다. 직접 이동하여 설치해주세요.")
                            .show();
                      }
                    },
                  )
                ],
              );
            });
      } else {
        if (accessToken != null && refreshToken != null) {
          await loginService.autoLogin(accessToken, refreshToken);
          if (loginService.isLogin.value) {
            Get.offAndToNamed(Routes.main);
          } else {
            Get.offAndToNamed(Routes.login);
          }
        } else {
          Get.offAndToNamed(Routes.login);
        }
      }
    }
  }
}
