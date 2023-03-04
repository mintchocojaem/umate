import 'package:danvery/app/controller/post_controller.dart';
import 'package:danvery/app/data/model/post_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/scheduler.dart';
import 'package:get/get.dart';
import '../../../../../routes/app_routes.dart';
import '../../../../controller/login_controller.dart';
import '../../../theme/app_colors.dart';
import '../../../widgets/app_bar/transparent_app_bar.dart';
import '../../../widgets/login/login_form_button.dart';

class PostCreatePage extends GetView {
  const PostCreatePage({super.key});

  @override
  Widget build(BuildContext context) {

    final PostController postController = Get.find<PostController>();

    final TextEditingController titleController = TextEditingController();
    final TextEditingController bodyController = TextEditingController();

    final LoginController loginController = Get.find<LoginController>();
    //토큰 받아올때 이렇게 직접적으로 받아오지말고 null 주고 logincontroller is loaded 됐을때 받아와야함

    return Scaffold(
        appBar: TransparentAppBar(
          title: '게시글 작성',
          automaticallyImplyLeading: true,
          onPressedLeading: () => Get.back(),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: <Widget>[
                      TextField(
                          controller: titleController,
                          decoration: InputDecoration(
                            border:
                                OutlineInputBorder(borderSide: BorderSide.none),
                            hintText: '제목',
                          )),
                      Divider(thickness: 1, color: brightGrey),
                      TextField(
                          controller: bodyController,
                          minLines: 1,
                          maxLines: 20,
                          decoration: InputDecoration(
                            border:
                                OutlineInputBorder(borderSide: BorderSide.none),
                            hintText: '내용',
                          )),
                      Divider(thickness: 1, color: brightGrey),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            "사진 첨부하기",
                            style: TextStyle(
                                fontSize: 16.0,
                                fontWeight: FontWeight.bold,
                                color: grey),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(
                              width: 80,
                              height: 80,
                              margin: EdgeInsets.only(
                                  top: 10.0, right: 10.0, bottom: 30.0),
                              decoration: BoxDecoration(
                                color: whiteGrey,
                              ),
                              child: IconButton(
                                  onPressed: () {},
                                  icon: Icon(
                                    Icons.image_outlined,
                                    color: grey,
                                  ))),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 16),
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: LoginFormButton(
                    text: "글 올리기",
                    onPressed: () {
                      PostModel postModel = PostModel();
                      postModel.title = titleController.text;
                      postModel.body = bodyController.text;
                      postController.createPost(loginController.loginModel.accessToken, postModel).then((value) {
                        if (value) {
                          Get.back();
                        } else {
                          Get.snackbar("Error", "게시글 업로드에 실패했습니다.");
                        }
                      });
                    },
                  ),
                ),
              ),
            ],
          ),
        ));
  }
}
