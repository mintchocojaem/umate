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
    return Container(
      child: LoginFormField(hint: '이메일 입력하세요',),
    );
  }

}
