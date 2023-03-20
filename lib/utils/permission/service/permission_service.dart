import 'package:danvery/utils/notification/setup_notification.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:permission_handler/permission_handler.dart';

class PermissionService extends GetxService with WidgetsBindingObserver{

  final RxBool _notificationPermission = false.obs;

  bool get notificationPermission => _notificationPermission.value;

  set notificationPermission(bool value) =>
      _notificationPermission.value = value;

  bool isOpenAppSettings = false;

  final GetStorage box = GetStorage();

  @override
  void onInit() async{
    super.onInit();

    WidgetsBinding.instance.addObserver(this);
    _notificationPermission.value = box.read('notificationPermission') ?? false;
    _notificationPermission.listen((value) {
      if (value) {
        getToken();
      } else {
        removeToken();
      }
      box.write('notificationPermission', notificationPermission);
    });
  }


  Future<void> getNotificationPermission() async {
    final bool isShouldShowRationale =
        await Permission.notification.shouldShowRequestRationale;
    final status = await Permission.notification.status;

    if (await Permission.notification.status.isGranted) {
      _notificationPermission.value = true;
    }

    if (status.isDenied) {
      await Permission.notification.request();
    } else if (status.isPermanentlyDenied || isShouldShowRationale) {
      isOpenAppSettings = true;
      await openAppSettings();
    }
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
        if (isOpenAppSettings) {
          isOpenAppSettings = false;
          _notificationPermission.value = await Permission.notification.isGranted;
        } else if (_notificationPermission.value != await Permission.notification.isGranted) {
          _notificationPermission.value = false;
        }
        break;
      default:
    }
  }

}
