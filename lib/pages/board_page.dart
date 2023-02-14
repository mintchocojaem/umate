import 'dart:convert';
import 'package:danvery/model/login_model.dart';
import 'package:danvery/model/petition_model.dart';
import 'package:danvery/model/post_model.dart';
import 'package:danvery/model/user_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../dto/board_list_dto.dart';
import '../main.dart';
import '../settings/palette.dart';

class BoardPage extends StatefulWidget {
  const BoardPage({super.key});

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _BoardPage();
  }
}

class _BoardPage extends State<BoardPage> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    return Scaffold(
      appBar: AppBar(
        title: Text(
          '자유게시판',
          style: TextStyle(fontSize: 20, color: Palette.black),
        ),
        centerTitle: true,
        leading: IconButton(icon: Icon(Icons.arrow_back_ios), onPressed: null),
        actions: [
          IconButton(icon: Icon(Icons.search), onPressed: null),
          IconButton(icon: Icon(Icons.mode_edit_outline), onPressed: null),
        ],
        backgroundColor: Palette.white,
      ),
      body: Column(
        children: [
          NoticeCard(
              category: "공지",
              title: "셔틀버스 시간 변경 안내",
              commentCnt: 8,
              likeCnt: 9),
          NoticeCard(
              category: "인기",
              title: "오늘",
              imageCnt: 2,
              commentCnt: 2,
              likeCnt: 24),
          PostCard(
              category: "자유게시판",
              title: "졸업하면",
              content: "돈 많이 벌어야지",
              imageCnt: 2,
              commentCnt: 2,
              likeCnt: 24),
          PostCard(
              category: "자유게시판",
              title: "졸업하면",
              content: "돈 많이 벌어야지",
              imageCnt: 2,
              commentCnt: 2,
              likeCnt: 24),
        ],
      ),
    );
  }
}

class NoticeCard extends StatelessWidget {
  final String category;
  final String title;
  final int? imageCnt;
  final int? commentCnt;
  final int? likeCnt;

  const NoticeCard(
      {super.key,
      required this.category,
      required this.title,
      this.imageCnt,
      this.commentCnt,
      this.likeCnt});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16.0),
          ),
          elevation: 4.0,
          margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 25.0),
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 5.0),
            child: ListTile(
              leading: Text(
                category,
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Palette.blue),
              ),
              title: Text(
                title,
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Palette.black),
              ),
              trailing: FittedBox(
                fit: BoxFit.fill,
                child: Row(
                  children: <Widget>[
                    Wrap(
                      spacing: 12,
                      children: [
                        imageCnt != null
                            ? Row(
                                children: [
                                  Icon(Icons.image_outlined),
                                  Text(
                                    imageCnt.toString(),
                                    style: TextStyle(
                                        fontSize: 20, color: Palette.grey),
                                  ),
                                ],
                              )
                            : Row(),
                        commentCnt != null
                            ? Row(
                                children: [
                                  Icon(Icons.chat_outlined),
                                  Text(
                                    commentCnt.toString(),
                                    style: TextStyle(
                                        fontSize: 20, color: Palette.grey),
                                  ),
                                ],
                              )
                            : Row(),
                        likeCnt != null
                            ? Row(
                                children: [
                                  Icon(Icons.thumb_up_off_alt),
                                  Text(
                                    likeCnt.toString(),
                                    style: TextStyle(
                                        fontSize: 20, color: Palette.grey),
                                  ),
                                ],
                              )
                            : Row(),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          )),
    );
  }
}

class PostCard extends StatelessWidget {
  final String category;
  final String title;
  final String content;
  final String? thumbnailUrl;
  final int? imageCnt;
  final int? commentCnt;
  final int? likeCnt;

  const PostCard(
      {super.key,
      required this.category,
      required this.title,
      required this.content,
      this.thumbnailUrl,
      this.imageCnt,
      this.commentCnt,
      this.likeCnt});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ListTile(
          isThreeLine: true,
          title: Text(
            title,
            style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Palette.black),
          ),
          subtitle: Text(content),
          trailing: Column(
            children: [
              FittedBox(
                fit: BoxFit.fill,
                child: Row(
                  children: <Widget>[
                    Wrap(
                      spacing: 12,
                      children: [
                        imageCnt != null
                            ? Row(
                                children: [
                                  Icon(Icons.image_outlined),
                                  Text(
                                    imageCnt.toString(),
                                    style: TextStyle(
                                        fontSize: 20, color: Palette.grey),
                                  ),
                                ],
                              )
                            : Row(),
                        commentCnt != null
                            ? Row(
                                children: [
                                  Icon(Icons.chat_outlined),
                                  Text(
                                    commentCnt.toString(),
                                    style: TextStyle(
                                        fontSize: 20, color: Palette.grey),
                                  ),
                                ],
                              )
                            : Row(),
                        likeCnt != null
                            ? Row(
                                children: [
                                  Icon(Icons.thumb_up_off_alt),
                                  Text(
                                    likeCnt.toString(),
                                    style: TextStyle(
                                        fontSize: 20, color: Palette.grey),
                                  ),
                                ],
                              )
                            : Row(),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          )),
    );
  }
}
