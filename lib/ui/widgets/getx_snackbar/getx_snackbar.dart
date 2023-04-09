import 'package:danvery/core/theme/palette.dart';
import 'package:get/get.dart';

enum GetXSnackBarType {
  customError,
  phoneNumberError,
  nickNameError,
  passwordInputError,
  passwordConfirmError,
  info,
  notificationPermissionError,
  cameraPermissionError,
  galleryPermissionError,
}

class GetXSnackBar {
  String title;
  String content;
  final GetXSnackBarType type;

  GetXSnackBar({required this.type, this.title = '제목', this.content = '내용'}) {
    switchSnackBarType();
  }

  switchSnackBarType() {
    switch (type) {
      case GetXSnackBarType.customError:
        break;
      case GetXSnackBarType.phoneNumberError:
        title = "휴대폰 번호 오류";
        content = "휴대폰 번호를 확인해주세요";
        break;
      case GetXSnackBarType.nickNameError:
        title = "닉네임 오류";
        content = "닉네임은 3~12자, 한글, 영문, 숫자, _, 공백만 포함할 수 있습니다";
        break;
      case GetXSnackBarType.passwordInputError:
        title = "비밀번호 오류";
        content = "비밀번호는 8~24자, 하나 이상의 영문자와 숫자, 특수문자만 포함할 수 있습니다";
        break;
      case GetXSnackBarType.passwordConfirmError:
        title = "비밀번호 오류";
        content = "비밀번호가 일치하지 않습니다";
        break;
      case GetXSnackBarType.info:
        break;
      case GetXSnackBarType.notificationPermissionError:
        title = "알림 권한 오류";
        content = "알림 권한을 허용해주세요";
        break;
      case GetXSnackBarType.cameraPermissionError:
        title = "카메라 권한 오류";
        content = "카메라 권한을 허용해주세요";
        break;
      case GetXSnackBarType.galleryPermissionError:
        title = "갤러리 권한 오류";
        content = "갤러리 권한을 허용해주세요";
        break;
    }
  }

  void show() {
    Get.snackbar(
        title,
        content,
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Palette.lightGrey,
        colorText: Palette.darkGrey,
        duration: const Duration(seconds: 3),
    );
  }

}

Future<void> closeSnackBarAndGetBack() async {
  await Get.closeCurrentSnackbar();
  await Future.delayed(const Duration(milliseconds: 100), () {
    Get.back();
  });
}
