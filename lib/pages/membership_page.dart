import 'package:danvery/widgets/login_form_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../widgets/login_form_field.dart';

class MembershipPage extends StatefulWidget{
  const MembershipPage({super.key});

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _MembershipPage();
  }

}

class _MembershipPage extends State<MembershipPage>{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    return Padding(
      padding: const EdgeInsets.only(left: 16, right: 16, top: 16, bottom: 16),
      child: Stack(
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height - (48 + 60 + 48),
            //60 = bottom navigation bar height, 48 = login button height, 48 = padding bottom 16 top 16 + else(?) 16
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Column(
                    children: const [
                      Padding(
                        padding: EdgeInsets.only(bottom: 8),
                        child: LoginFormField(
                          hint: '이메일 입력하세요',
                          title: "단국대학교 이메일",
                          checkButton: true,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 8, bottom: 8),
                        child: LoginFormField(
                          hint: "이름을 입력하세요",
                          title: "이름",
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 8, bottom: 8),
                        child: LoginFormField(
                          hint: "비밀번호를 입력하세요",
                          title: "비밀번호",
                          validateHint: "비밀번호를 재입력하세요",
                          validate: true,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 8, bottom: 8),
                        child: LoginFormField(
                          hint: "전공을 선택하세요",
                          title: "전공",
                          dropdown: true,
                          dropdownData: ["경영학과","소프트웨어학과","국문어학과"],
                        ),
                      ),
                      //휴대폰 번호 인증 필요
                      Padding(
                          padding: EdgeInsets.only(top: 8, bottom: 8),
                          child: LoginFormField(
                            hint: "- 는 제외하고 입력하세요",
                            validate: true,
                            validateHint: "인증번호 6자리를 입력하세요",
                            title: "휴대폰 번호",
                            checkButton: true,
                            checkButtonText: "인증요청"
                          ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: LoginFormButton(text: "가입하기",
              onPressed : (){

              },
            ),
          )
        ],
      ),
    );
  }

}
