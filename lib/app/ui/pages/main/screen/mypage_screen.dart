import 'package:danvery/app/ui/theme/app_colors.dart';
import 'package:danvery/app/ui/theme/app_text_theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:get/get.dart';

class MyPageScreen extends GetView {
  const MyPageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    bool notification = true;

    return SafeArea(
      child: Stack(
        children: [
          Container(
            height: 300,
            color: blue,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(left: 12, right: 12, top: 36),
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
                                  style: titleStyle.copyWith(color: white),
                                  text: '김단국\n', // default text style
                                  children: <TextSpan>[
                                    TextSpan(
                                        text: "경영경제대학 경영학과\n",
                                        style: regularStyle.copyWith(
                                            color: white)),
                                    TextSpan(
                                        text: "32XXXXXX",
                                        style: regularStyle.copyWith(
                                            color: white)),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          TextButton(
                              style: TextButton.styleFrom(
                                backgroundColor: grey,
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
                                  style: regularStyle.copyWith(color: white),
                                ),
                              )),
                        ],
                      ),
                      const SizedBox(height: 36,),
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
                                    style: titleStyle.copyWith(color: black),
                                  ),
                                  Text(
                                    "내가 쓴 글",
                                    style: regularStyle.copyWith(color: black),
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
                                    style: titleStyle.copyWith(color: black),
                                  ),
                                  Text(
                                    "내가 쓴 댓글",
                                    style: regularStyle.copyWith(color: black),
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
                                    style: titleStyle.copyWith(color: black),
                                  ),
                                  Text(
                                    "내가 좋아요한 글",
                                    style: regularStyle.copyWith(color: black),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 100,
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
                              style: regularStyle.copyWith(color: black),
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
                              style: regularStyle.copyWith(color: black),
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
                              style: regularStyle.copyWith(color: black),
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
