import 'package:danvery/app/controller/post_controller.dart';
import 'package:danvery/app/data/model/post_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import '../../../../controller/login_controller.dart';
import '../../../theme/app_colors.dart';

import 'package:image_picker/image_picker.dart';

class NewPostPage extends GetView {
  const NewPostPage({super.key});

  @override
  Widget build(BuildContext context) {
    final PostController postController = Get.find<PostController>();

    final TextEditingController titleController = TextEditingController();
    final TextEditingController bodyController = TextEditingController();

    final String token = Get.find<LoginController>().loginModel.accessToken;
    //토큰 받아올때 이렇게 직접적으로 받아오지말고 null 주고 logincontroller is loaded 됐을때 받아와야함

    void backButtonDialog() {
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return CupertinoAlertDialog(
              title: Text("작성한 내용이 지워집니다.\n나가시겠습니까?"),
              actions: [
                CupertinoDialogAction(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text(
                      "취소",
                      style: TextStyle(color: black),
                    )),
                CupertinoDialogAction(
                    onPressed: () {
                      Navigator.pop(context);
                      Navigator.pop(context);
                    },
                    child: Text(
                      "나가기",
                      style: TextStyle(color: blue),
                    )),
              ],
            );
          });
    }

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(100.0),
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: AppBar(
            leading: IconButton(
                icon: Icon(
                  Icons.arrow_back_ios,
                  color: black,
                ),
                onPressed: () => backButtonDialog()),
            title: Text(
              '글 작성하기',
              style: TextStyle(fontSize: 20, color: black),
            ),
            centerTitle: true,
            backgroundColor: Colors.transparent,
            elevation: 0,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            children: <Widget>[
              TextField(
                  controller: titleController,
                  decoration: InputDecoration(
                border: OutlineInputBorder(borderSide: BorderSide.none),
                hintText: '제목',
              )),
              Divider(thickness: 1, color: brightGrey),
              TextField(
                  controller: bodyController,
                  maxLines: 20,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(borderSide: BorderSide.none),
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
                      margin:
                          EdgeInsets.only(top: 10.0, right: 10.0, bottom: 30.0),
                      decoration: BoxDecoration(
                        color: whiteGrey,
                      ),
                      child: IconButton(
                          onPressed: (){

                          },
                          icon: Icon(
                            Icons.image_outlined,
                            color: grey,
                          ))),
                ],
              ),
              ElevatedButton(
                child: Text("게시글 업로드"),
                style: ElevatedButton.styleFrom(
                    fixedSize: Size(Get.width, 50),
                    textStyle: const TextStyle(fontSize: 16.0),
                    backgroundColor: blue),
                onPressed: () {
                  PostModel postModel = PostModel();
                  postModel.title = titleController.text;
                  postModel.body = bodyController.text;
                  postController.createPost(token,postModel).then((value) {
                    if (value) {

                      Get.back();
                    } else {
                      Get.snackbar("Error", "게시글 업로드에 실패했습니다.");
                    }
                  });
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
