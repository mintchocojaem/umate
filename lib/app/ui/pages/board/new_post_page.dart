import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import '../../theme/app_colors.dart';
import '../../theme/app_text_theme.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';

class NewPostPage extends StatefulWidget {
  @override
  _NewPostPageState createState() => _NewPostPageState();
}

class _NewPostPageState extends State<NewPostPage> {
  final changedContent = false; //변경된 내용이 있으면 true
  final ImagePicker _picker = ImagePicker();
  List<XFile> _pickedImgs = []; // 이미지 저장 배열

  Future<void> _pickImg() async {
    //이미지 업로드 함수
    final List<XFile>? images = await _picker.pickMultiImage();
    if (images != null) {
      setState(() {
        _pickedImgs = images;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

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
                  decoration: InputDecoration(
                border: OutlineInputBorder(borderSide: BorderSide.none),
                hintText: '제목',
              )),
              Divider(thickness: 1, color: brightGrey),
              TextField(
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
                          onPressed: () => _pickImg(),
                          icon: Icon(
                            Icons.image_outlined,
                            color: grey,
                          ))),
                ],
              ),
              ElevatedButton(
                child: Text("게시글 업로드"),
                style: ElevatedButton.styleFrom(
                    fixedSize: Size(screenWidth, 50),
                    textStyle: const TextStyle(fontSize: 16.0),
                    backgroundColor: blue),
                onPressed: () {},
              ),
            ],
          ),
        ),
      ),
    );
  }
}
