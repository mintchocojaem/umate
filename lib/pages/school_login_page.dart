import 'package:danvery/settings/font_size.dart';
import 'package:danvery/settings/palette.dart';
import 'package:danvery/widgets/login_form_field.dart';
import 'package:flutter/cupertino.dart';

class SchoolLoginPage extends StatefulWidget{
  const SchoolLoginPage({super.key});

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _SchoolLoginPage();
  }

}

class _SchoolLoginPage extends State<SchoolLoginPage>{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.only(left: 16, right: 16, top: 16, bottom: 16),
        child: Column(
          children: [
            Column(
              children: [
                Image.asset(
                  "assets/icons/school_mark/dankook_emblem.png",
                  width: 200,
                  height: 200,
                ),
                const Padding(
                  padding: EdgeInsets.only(bottom: 8),
                  child: LoginFormField(
                    hint: '32XXXXXX',
                    title: "학번",
                    readOnly: true,
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.only(top: 8, bottom: 8),
                  child: LoginFormField(
                    hint: "비밀번호를 입력하세요",
                    title: "비밀번호",
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 48,
            ),
            SizedBox(
              width: double.infinity,
              height: 48,
              child: CupertinoButton(
                color: Palette.blue,
                onPressed: () {},
                child: const Text(
                  "인증",
                  style: TextStyle(
                    fontSize: FontSize.regularFont,
                  )
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
