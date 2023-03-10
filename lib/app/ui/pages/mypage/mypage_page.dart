import 'package:danvery/app/ui/theme/app_text_theme.dart';
import 'package:danvery/app/ui/theme/palette.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:get/get.dart';

import '../../widgets/app_bar/main_app_bar.dart';

class MyPagePage extends GetView {
  const MyPagePage({super.key});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    bool notification = true;

    return Scaffold(
      backgroundColor: Palette.pureWhite,
      appBar: MainAppBar(
        title: "Danvery",
        titleColor: Palette.pureWhite,
        backGroundColor: Palette.blue,
      ),
      body: Stack(
        children: [
          Container(
            height: 200,
            color: Palette.blue,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(left: 16, right: 16, top: 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Column(
                                children: [
                                  CircleAvatar(
                                    radius: 36,
                                    backgroundImage: Image.asset(
                                            "assets/icons/user/default_user_icon.png")
                                        .image,
                                    backgroundColor: Colors.transparent,
                                  ),
                                ],
                              ),
                              const SizedBox(
                                width: 32,
                              ),
                              Text.rich(
                                TextSpan(
                                  style: titleStyle.copyWith(color: Palette.pureWhite),
                                  text: '김단국\n', // default text style
                                  children: <TextSpan>[
                                    TextSpan(
                                        text: "경영경제대학 경영학과\n",
                                        style: regularStyle.copyWith(
                                            color: Palette.pureWhite)),
                                    TextSpan(
                                        text: "32XXXXXX",
                                        style: regularStyle.copyWith(
                                            color: Palette.pureWhite)),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          TextButton(
                              style: TextButton.styleFrom(
                                backgroundColor: Palette.grey,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                              ),
                              onPressed: () {},
                              child: Padding(
                                padding:
                                    const EdgeInsets.only(left: 8, right: 8),
                                child: Text(
                                  "프로필 수정",
                                  style: regularStyle.copyWith(color: Palette.pureWhite),
                                ),
                              )),
                        ],
                      ),
                      const SizedBox(height: 20,),
                      Card(
                        child: Padding(
                          padding: const EdgeInsets.all(16),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Column(
                                children: [
                                  Text(
                                    "0",
                                    style: titleStyle.copyWith(color: Palette.darkGrey),
                                  ),
                                  Text(
                                    "내가 쓴 글",
                                    style: regularStyle.copyWith(color: Palette.darkGrey),
                                  ),
                                ],
                              ),
                              SizedBox(
                                width: 24,
                              ),
                              Column(
                                children: [
                                  Text(
                                    "0",
                                    style: titleStyle.copyWith(color: Palette.darkGrey),
                                  ),
                                  Text(
                                    "내가 쓴 댓글",
                                    style: regularStyle.copyWith(color: Palette.darkGrey),
                                  ),
                                ],
                              ),
                              SizedBox(
                                width: 24,
                              ),
                              Column(
                                children: [
                                  Text(
                                    "0",
                                    style: titleStyle.copyWith(color: Palette.darkGrey),
                                  ),
                                  Text(
                                    "내가 좋아요한 글",
                                    style: regularStyle.copyWith(color: Palette.darkGrey),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 40,
                      ),
                      SizedBox(
                        width: double.infinity,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("알림 설정", style: regularStyle),
                            FlutterSwitch(
                              width: 60.0,
                              toggleSize: 25.0,
                              value: notification,
                              borderRadius: 30.0,
                              onToggle: (val) {

                              },
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        width: double.infinity,
                        child: TextButton(
                            style: TextButton.styleFrom(
                                padding: EdgeInsets.zero,
                                alignment: Alignment.centerLeft),
                            onPressed: () {},
                            child: Text(
                              "디스플레이 설정",
                              style: regularStyle.copyWith(color: Palette.darkGrey),
                            )
                        ),
                      ),
                      SizedBox(
                        width: double.infinity,
                        child: TextButton(
                            style: TextButton.styleFrom(
                                padding: EdgeInsets.zero,
                                alignment: Alignment.centerLeft),
                            onPressed: () {},
                            child: Text(
                              "로그아웃",
                              style: regularStyle.copyWith(color: Palette.darkGrey),
                            )
                        ),
                      ),
                      SizedBox(
                        width: double.infinity,
                        child: TextButton(
                            style: TextButton.styleFrom(
                                padding: EdgeInsets.zero,
                                alignment: Alignment.centerLeft),
                            onPressed: () {},
                            child: Text(
                              "회원탈퇴",
                              style: regularStyle.copyWith(color: Palette.darkGrey),
                            )
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
