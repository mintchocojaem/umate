import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';

class PermissionController extends SuperController {
  final RxBool _notificationPermission = false.obs;

  bool get notificationPermission => _notificationPermission.value;

  set notificationPermission(bool value) =>
      _notificationPermission.value = value;

  bool isOpenAppSettings = false;

  @override
  void onInit() async {
    super.onInit();
    _notificationPermission.value = await Permission.notification.isGranted;
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
  void onDetached() {
    // TODO: implement onDetached
  }

  @override
  void onInactive() {
    // TODO: implement onInactive
  }

  @override
  void onPaused() {
    // TODO: implement onPaused
  }

  @override
  void onResumed() async {
    // TODO: implement onResumed

    if (isOpenAppSettings) {
      isOpenAppSettings = false;
      _notificationPermission.value = await Permission.notification.isGranted;
    } else if (_notificationPermission.value != await Permission.notification.isGranted) {
      _notificationPermission.value = false;
    }

  }
}
