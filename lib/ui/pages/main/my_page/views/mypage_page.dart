import 'package:danvery/core/theme/palette.dart';
import 'package:danvery/routes/app_routes.dart';
import 'package:danvery/ui/pages/main/my_page/controller/mypage_page_controller.dart';
import 'package:danvery/core/theme/app_text_theme.dart';
import 'package:danvery/ui/widgets/app_bar/main_app_bar.dart';
import 'package:danvery/ui/widgets/getx_snackbar/getx_snackbar.dart';
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
        actions: [],
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
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          controller.validNickname.value,
                                          // default text styles
                                          style: titleStyle.copyWith(
                                              fontWeight: FontWeight.bold,
                                              color: Palette.pureWhite,
                                              overflow: TextOverflow.ellipsis),
                                          maxLines: 1,
                                        ),
                                        Text(
                                          controller.loginService.userInfo.value
                                              .username,
                                          style: smallTitleStyle.copyWith(
                                            color: Palette.white,
                                            fontWeight: FontWeight.bold,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                          maxLines: 1,
                                        ),
                                        Text(
                                          "${controller.loginService.userInfo.value.department} "
                                          "${controller.loginService.userInfo.value.major}",
                                          style: regularStyle.copyWith(
                                            color: Palette.white,
                                            fontWeight: FontWeight.bold,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                          maxLines: 2,
                                        ),
                                      ],
                                    ),
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
                            InkWell(
                              child: SizedBox(
                                width: double.infinity,
                                height: 60,
                                child: Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    "피드백 보내기",
                                    style: smallTitleStyle.copyWith(
                                      fontWeight: FontWeight.normal,
                                    ),
                                  ),
                                ),
                              ),
                              onTap: () async {
                                await controller.sendEmail();
                              },
                            ),
                            InkWell(
                              child: SizedBox(
                                width: double.infinity,
                                height: 60,
                                child: Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    "로그아웃",
                                    style: smallTitleStyle.copyWith(
                                      fontWeight: FontWeight.normal,
                                    ),
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
                            InkWell(
                              child: SizedBox(
                                width: double.infinity,
                                height: 60,
                                child: Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    "회원탈퇴",
                                    style: smallTitleStyle.copyWith(
                                      fontWeight: FontWeight.normal,
                                      color: Palette.lightRed,
                                    ),
                                  ),
                                ),
                              ),
                              onTap: () async {
                                controller.withdrawController.value.text = "";
                                showCupertinoDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return CupertinoAlertDialog(
                                      title: const Text("회원탈퇴"),
                                      content: Column(
                                        children: [
                                          const Text("정말로 회원탈퇴 하시겠습니까?"),
                                          const SizedBox(
                                            height: 8,
                                          ),
                                          CupertinoTextField(
                                            textAlign: TextAlign.center,
                                            controller: controller
                                                .withdrawController.value,
                                            autofocus: true,
                                            placeholder: "\"회원탈퇴\"를 입력해주세요",
                                            style: regularStyle.copyWith(
                                              color: Palette.lightRed,
                                            ),
                                            decoration: BoxDecoration(
                                              border: Border(
                                                bottom: BorderSide(
                                                  color: Palette.lightGrey,
                                                  width: 0.5,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
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
                                            if (controller.withdrawController
                                                    .value.text ==
                                                "회원탈퇴") {
                                              await controller.loginService.withdraw();
                                            } else {
                                              GetXSnackBar(
                                                type: GetXSnackBarType
                                                    .customError,
                                                title: "회원탈퇴 실패",
                                                content:
                                                    "회원탈퇴를 위해 \"회원탈퇴\"를 입력해주세요",
                                              ).show();
                                            }
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
                            InkWell(
                              onTap: () async {
                                controller.myPagePostType = [
                                  MyPagePostType.general,
                                  MyPagePostType.petition
                                ];
                                Get.toNamed(Routes.myPagePost);
                              },
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    controller.userWritePostCount.value
                                        .toString(),
                                    style: smallTitleStyle.copyWith(
                                        color: Palette.darkGrey),
                                  ),
                                  const SizedBox(
                                    height: 8,
                                  ),
                                  Text(
                                    "게시한 글",
                                    style: regularStyle.copyWith(
                                        color: Palette.darkGrey),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(
                              width: 32,
                            ),
                            InkWell(
                              onTap: () async {
                                controller.myPagePostType = [
                                  MyPagePostType.comment
                                ];
                                Get.toNamed(Routes.myPagePost);
                              },
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    controller.userCommentedPostCount.value
                                        .toString(),
                                    style: smallTitleStyle.copyWith(
                                        color: Palette.darkGrey),
                                  ),
                                  const SizedBox(
                                    height: 8,
                                  ),
                                  Text(
                                    "댓글 단 글",
                                    style: regularStyle.copyWith(
                                        color: Palette.darkGrey),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(
                              width: 32,
                            ),
                            InkWell(
                              onTap: () async {
                                controller.myPagePostType = [
                                  MyPagePostType.like
                                ];
                                Get.toNamed(Routes.myPagePost);
                              },
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    controller.userLikedPostCount.value
                                        .toString(),
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
