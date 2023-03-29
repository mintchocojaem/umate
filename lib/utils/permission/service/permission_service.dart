import 'package:danvery/utils/notification/setup_notification.dart';
import 'package:danvery/utils/theme/palette.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:permission_handler/permission_handler.dart';

class PermissionService extends GetxService with WidgetsBindingObserver {

  final RxBool notificationPermission = false.obs;
  final RxBool cameraPermission = false.obs;
  final RxBool galleryPermission = false.obs;

  final GetStorage box = GetStorage();

  @override
  void onInit() async {
    super.onInit();

    WidgetsBinding.instance.addObserver(this);
    notificationPermission.value = box.read('notificationPermission') ??
        await Permission.notification.isGranted;
    notificationPermission.listen((value) {
      if (value) {
        getToken();
      } else {
        removeToken();
      }
      box.write('notificationPermission', notificationPermission.value);
    });
  }

  Future<bool> getNotificationPermission() async {
    final bool isShouldShowRationale =
        await Permission.notification.shouldShowRequestRationale;
    final status = await Permission.notification.status;

    if (await Permission.notification.status.isGranted) {
      notificationPermission.value = true;
      return true;
    }

    if (status.isDenied) {
      return await Permission.notification.request().isGranted;
    } else if (status.isPermanentlyDenied || isShouldShowRationale) {
      Get.snackbar('알림 권한', '설정에서 알림 권한을 허용해주세요.',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Palette.darkGrey,
          colorText: Palette.pureWhite);
    }
    return false;
  }

  Future<bool> getCameraPermission() async {
    final bool isShouldShowRationale =
        await Permission.camera.shouldShowRequestRationale;
    final status = await Permission.camera.status;

    if (await Permission.camera.status.isGranted) {
      cameraPermission.value = true;
      return true;
    }

    if (status.isDenied) {
      return await Permission.camera.request().isGranted;
    } else if (status.isPermanentlyDenied || isShouldShowRationale) {
      Get.snackbar('카메라 권한', '설정에서 카메라 권한을 허용해주세요.',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Palette.darkGrey,
          colorText: Palette.pureWhite);
    }
    return false;
  }

  Future<bool> getGalleryPermission() async {
    final bool isShouldShowRationale =
        await Permission.photos.shouldShowRequestRationale;
    final status = await Permission.photos.status;

    if (await Permission.photos.status.isGranted || status.isLimited) {
      galleryPermission.value = true;
      return true;
    }

    if (status.isDenied) {
      return await Permission.photos.request().isGranted;
    } else if (status.isPermanentlyDenied || isShouldShowRationale) {
      Get.snackbar('갤러리 권한', '설정에서 갤러리 권한을 허용해주세요.',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Palette.darkGrey,
          colorText: Palette.pureWhite);
    }
    return false;
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) async {
    switch (state) {
      case AppLifecycleState.detached:
        break;
      case AppLifecycleState.paused:
        break;
      case AppLifecycleState.inactive:
        break;
      case AppLifecycleState.resumed:
        if(notificationPermission.value) {
          notificationPermission.value = await Permission.notification.isGranted;
        }
        break;
      default:
    }
  }
}
