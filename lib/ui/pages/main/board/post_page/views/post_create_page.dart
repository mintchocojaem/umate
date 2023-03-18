import 'package:danvery/domain/auth/login/services/login_service.dart';
import 'package:danvery/ui/pages/main/board/post_page/controller/post_page_controller.dart';
import 'package:danvery/utils/theme/palette.dart';
import 'package:danvery/ui/widgets/app_bar/transparent_app_bar.dart';
import 'package:danvery/ui/widgets/login/login_form_button.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../../domain/board/post/model/post_model.dart';

class PostCreatePage extends GetView<PostPageController> {
  const PostCreatePage({super.key});

  @override
  Widget build(BuildContext context) {
    //토큰 받아올때 이렇게 직접적으로 받아오지말고 null 주고 logincontroller is loaded 됐을때 받아와야함

    return Scaffold(
        appBar: TransparentAppBar(
          isDarkMode: Get.isDarkMode,
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
                          decoration: InputDecoration(
                        border: OutlineInputBorder(borderSide: BorderSide.none),
                        hintText: '제목',
                      )),
                      Divider(thickness: 1, color: Palette.darkGrey),
                      TextField(
                          minLines: 1,
                          maxLines: 20,
                          decoration: InputDecoration(
                            border:
                                OutlineInputBorder(borderSide: BorderSide.none),
                            hintText: '내용',
                          )),
                      Divider(thickness: 1, color: Palette.darkGrey),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            "사진 첨부하기",
                            style: TextStyle(
                                fontSize: 16.0,
                                fontWeight: FontWeight.bold,
                                color: Palette.grey),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(
                              width: 80,
                              height: 80,
                              margin: const EdgeInsets.only(
                                  top: 10.0, right: 10.0, bottom: 30.0),
                              decoration: BoxDecoration(
                                color: Palette.white,
                              ),
                              child: IconButton(
                                  onPressed: () {},
                                  icon: Icon(
                                    Icons.image_outlined,
                                    color: Palette.grey,
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
                      controller.postController
                          .createPost(
                              controller.loginService.loginModel.accessToken,
                              postModel)
                          .then((value) {
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
