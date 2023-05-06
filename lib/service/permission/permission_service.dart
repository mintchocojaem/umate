import 'dart:io';

import 'package:danvery/core/notification/setup_notification.dart';
import 'package:device_info_plus/device_info_plus.dart';
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
      openAppSettings();
    }
    return false;
  }

  Future<bool> getCameraPermission() async{
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
      openAppSettings();
    }
    return false;
  }

  Future<bool> getGalleryPermission() async {

    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();

    if (Platform.isAndroid && (await DeviceInfoPlugin().androidInfo).version.sdkInt <= 32) {
      /// use [Permissions.storage.status]

      final bool isShouldShowRationale =
      await Permission.storage.shouldShowRequestRationale;

      final status = await Permission.storage.status;

      if (await Permission.storage.status.isGranted || status.isLimited) {
        galleryPermission.value = true;
        return true;
      }

      if (status.isDenied) {
        if(await Permission.storage.request().isGranted) return true;
      } else if (status.isPermanentlyDenied || isShouldShowRationale) {
        openAppSettings();
      }

    }else{
      /// use [Permissions.photos.status]
      final bool isShouldShowRationale =
      await Permission.photos.shouldShowRequestRationale;
      final status = await Permission.photos.status;
      if (await Permission.photos.status.isGranted || status.isLimited) {
        galleryPermission.value = true;
        return true;
      }
      if (status.isDenied) {
        if(await Permission.photos.request().isGranted) return true;
      } else if (status.isPermanentlyDenied || isShouldShowRationale) {
        openAppSettings();
      }
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
