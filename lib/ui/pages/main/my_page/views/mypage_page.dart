import 'package:danvery/core/theme/palette.dart';
import 'package:danvery/ui/pages/main/my_page/controller/mypage_page_controller.dart';
import 'package:danvery/core/theme/app_text_theme.dart';
import 'package:danvery/ui/widgets/app_bar/main_app_bar.dart';
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
      body: Stack(
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
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Column(
                              children: [
                                CircleAvatar(
                                  radius: 52,
                                  backgroundImage: Image.asset(
                                          "assets/icons/user/profile_icon.png")
                                      .image,
                                ),
                                /*
                                TextButton(
                                  style: TextButton.styleFrom(
                                    minimumSize: const Size(32, 16),
                                    padding: const EdgeInsets.only(
                                        top: 4, bottom: 4, left: 16, right: 16),
                                    backgroundColor: Palette.lightGrey,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                  ),
                                  onPressed: () {},
                                  child: Text(
                                    "프로필 수정",
                                    style: lightStyle.copyWith(
                                        color: Palette.darkGrey),
                                  ),
                                ),
                                 */
                              ],
                            ),
                            const SizedBox(
                              width: 16,
                            ),
                            Text.rich(
                              TextSpan(
                                style: titleStyle.copyWith(
                                    fontWeight: FontWeight.bold,
                                    color: Palette.pureWhite,
                                    overflow: TextOverflow.ellipsis),
                                text:
                                    '${controller.loginService.userInfo.value.nickname}\n', // default text style
                                children: <TextSpan>[
                                  TextSpan(
                                    text:
                                        "${controller.loginService.userInfo.value.department} "
                                        "${controller.loginService.userInfo.value.major}\n",
                                    style: regularStyle.copyWith(
                                        color: Palette.white,
                                        fontWeight: FontWeight.w600,
                                        overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                  TextSpan(
                                    text:
                                        "${controller.loginService.userInfo.value.studentId} "
                                            "${controller.loginService.userInfo.value.username}",
                                    style: regularStyle.copyWith(
                                        color: Palette.white,
                                        fontWeight: FontWeight.w600,
                                        overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ],
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
                      padding:
                          const EdgeInsets.only(top: 60.0, left: 16, right: 16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 60,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text("알림 설정",
                                    style: smallTitleStyle.copyWith(
                                      fontWeight: FontWeight.normal,
                                    )),
                                Obx(
                                  () => FlutterSwitch(
                                    inactiveColor: Palette.lightGrey,
                                    activeColor: Palette.lightGrey,
                                    inactiveToggleColor: Palette.blue,
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
                          GestureDetector(
                            onTap: () {},
                            child: SizedBox(
                                height: 60,
                                child: Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    "디스플레이 설정",
                                    style: smallTitleStyle.copyWith(
                                        fontWeight: FontWeight.normal,
                                        color: Palette.darkGrey),
                                  ),
                                )),
                          ),
                          /*
                          GestureDetector(
                            onTap: () {

                            },
                            child: SizedBox(
                                height: 60,
                                child: Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    "로그아웃",
                                    style: titleStyle.copyWith(
                                        fontWeight: FontWeight.normal,
                                        color: Palette.darkGrey),
                                  ),
                                )),
                          ),

                           */
                          /*
                          GestureDetector(
                            onTap: () {},
                            child: SizedBox(
                                height: 60,
                                child: Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    "회원탈퇴",
                                    style: titleStyle.copyWith(
                                        fontWeight: FontWeight.normal,
                                        color: Palette.darkGrey),
                                  ),
                                )),
                          ),

                           */
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
                            offset: Offset(0, 1), // changes position of shadow
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
                              SizedBox(
                                height: 8,
                              ),
                              Text(
                                "내가 쓴 글",
                                style: regularStyle.copyWith(
                                    color: Palette.darkGrey),
                              ),
                            ],
                          ),
                          SizedBox(
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
                              SizedBox(
                                height: 8,
                              ),
                              Text(
                                "내가 쓴 댓글",
                                style: regularStyle.copyWith(
                                    color: Palette.darkGrey),
                              ),
                            ],
                          ),
                          SizedBox(
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
                              SizedBox(
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
    );
  }
}
