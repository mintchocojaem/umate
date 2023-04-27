import 'package:danvery/core/theme/palette.dart';
import 'package:danvery/routes/app_routes.dart';
import 'package:danvery/ui/pages/main/my_page/controller/mypage_page_controller.dart';
import 'package:danvery/core/theme/app_text_theme.dart';
import 'package:danvery/ui/widgets/app_bar/main_app_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:get/get.dart';

class MyPagePage extends GetView<MyPagePageController> {
  const MyPagePage({super.key});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      backgroundColor: Palette.pureWhite,
      appBar: MainAppBar(
        backGroundColor: Palette.blue,
        isWhite: true,
        isDarkMode: !Get.isDarkMode,
      ),
      body: Obx(
        () => Stack(
          children: [
            Container(
              height: 300,
              color: Palette.blue,
            ),
            SingleChildScrollView(
              child: Stack(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(
                              right: 16, left: 16, bottom: 8, top: 24),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Image.asset(
                                    "assets/icons/user/profile_icon.png",
                                    width: 100,
                                    height: 100,
                                  ),
                                  const SizedBox(
                                    width: 16,
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        controller.loginService.userInfo.value
                                            .nickname,
                                        // default text styles
                                        style: titleStyle.copyWith(
                                            fontWeight: FontWeight.bold,
                                            color: Palette.pureWhite,
                                            overflow: TextOverflow.ellipsis),
                                      ),
                                      Text(
                                        controller.loginService.userInfo.value
                                            .username,
                                        style: smallTitleStyle.copyWith(
                                          color: Palette.white,
                                          fontWeight: FontWeight.bold,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                      Text(
                                        "${controller.loginService.userInfo.value.department} "
                                        "${controller.loginService.userInfo.value.major}",
                                        style: regularStyle.copyWith(
                                          color: Palette.white,
                                          fontWeight: FontWeight.bold,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 4,
                              ),
                              TextButton(
                                style: TextButton.styleFrom(
                                  maximumSize: const Size(100, 28),
                                  minimumSize: const Size(100, 28),
                                  padding: const EdgeInsets.only(
                                    top: 4,
                                    bottom: 4,
                                  ),
                                  backgroundColor: Palette.lightGrey,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                ),
                                onPressed: () {
                                  Get.toNamed(Routes.myPageEdit);
                                },
                                child: Text(
                                  "프로필 수정",
                                  style: lightStyle.copyWith(
                                      color: Palette.darkGrey),
                                ),
                              ),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 244),
                    child: Container(
                      color: Palette.pureWhite,
                      child: Padding(
                        padding: const EdgeInsets.only(
                            top: 60.0, left: 16, right: 16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: 60,
                              width: double.infinity,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "알림 설정",
                                    style: smallTitleStyle.copyWith(
                                      fontWeight: FontWeight.normal,
                                    ),
                                  ),
                                  Obx(
                                    () => FlutterSwitch(
                                      inactiveColor: Palette.lightGrey,
                                      activeColor: Palette.lightGrey,
                                      inactiveToggleColor: Palette.grey,
                                      activeToggleColor: Palette.blue,
                                      width: 60.0,
                                      toggleSize: 24.0,
                                      value: controller.permissionService
                                          .notificationPermission.value,
                                      borderRadius: 30.0,
                                      onToggle: (val) async {
                                        if (val) {
                                          await controller.permissionService
                                              .getNotificationPermission();
                                        } else {
                                          controller
                                              .permissionService
                                              .notificationPermission
                                              .value = false;
                                        }
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(
                              height: 16,
                            ),
                            InkWell(
                              child: SizedBox(
                                width: double.infinity,
                                height: 60,
                                child: Text(
                                  "로그아웃",
                                  style: smallTitleStyle.copyWith(
                                    fontWeight: FontWeight.normal,
                                  ),
                                ),
                              ),
                              onTap: () async {
                                showCupertinoDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return CupertinoAlertDialog(
                                      title: const Text("로그아웃"),
                                      content: const Text("로그아웃 하시겠습니까?"),
                                      actions: [
                                        CupertinoDialogAction(
                                          child: const Text(
                                            '취소',
                                          ),
                                          onPressed: () {
                                            Get.back();
                                          },
                                        ),
                                        CupertinoDialogAction(
                                          child: Text(
                                            '확인',
                                            style: TextStyle(
                                              color: Palette.lightRed,
                                            ),
                                          ),
                                          onPressed: () async {
                                            await controller.loginService
                                                .logout();
                                          },
                                        ),
                                      ],
                                    );
                                  },
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(top: 190.0, left: 16, right: 16),
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius:
                              const BorderRadius.all(Radius.circular(10)),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.3),
                              spreadRadius: 3,
                              blurRadius: 3,
                              offset: const Offset(
                                  0, 1), // changes position of shadow
                            ),
                          ],
                          color: Palette.pureWhite),
                      height: 100,
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "0",
                                  style: smallTitleStyle.copyWith(
                                      color: Palette.darkGrey),
                                ),
                                const SizedBox(
                                  height: 8,
                                ),
                                Text(
                                  "내가 쓴 글",
                                  style: regularStyle.copyWith(
                                      color: Palette.darkGrey),
                                ),
                              ],
                            ),
                            const SizedBox(
                              width: 32,
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "0",
                                  style: smallTitleStyle.copyWith(
                                      color: Palette.darkGrey),
                                ),
                                const SizedBox(
                                  height: 8,
                                ),
                                Text(
                                  "내가 쓴 댓글",
                                  style: regularStyle.copyWith(
                                      color: Palette.darkGrey),
                                ),
                              ],
                            ),
                            const SizedBox(
                              width: 32,
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "0",
                                  style: smallTitleStyle.copyWith(
                                      color: Palette.darkGrey),
                                ),
                                const SizedBox(
                                  height: 8,
                                ),
                                Text(
                                  "좋아요한 글",
                                  style: regularStyle.copyWith(
                                      color: Palette.darkGrey),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
