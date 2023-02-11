import 'package:danvery/settings/palette.dart';
import 'package:danvery/widgets/login_form_field.dart';
import 'package:flutter/cupertino.dart';

class LoginPage extends StatefulWidget{
  const LoginPage({super.key});

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _LoginPage();
  }

}

class _LoginPage extends State<LoginPage>{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Padding(
      padding: const EdgeInsets.only(left: 16, right: 16, top: 16, bottom: 16),
      child: Column(
        children: [
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
          )
        ],
      ),
    );
  }

}
