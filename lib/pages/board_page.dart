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
        leading: IconButton(icon: Icon(Icons.arrow_back_ios), onPressed: null),
        actions: [
          IconButton(icon: Icon(Icons.search), onPressed: null),
          IconButton(icon: Icon(Icons.mode_edit_outline), onPressed: null),
        ],
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
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
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Palette.blue),
              ),
              title: Text(
                title,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
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
        child: Padding(
      padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 25.0),
      child: ListTile(
          shape: Border(
            bottom: BorderSide(
              width: 0.5,
              color: Palette.lightGrey,
            ),
          ),
          isThreeLine: true,
          title: Text(
            title,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Palette.black),
          ),
          subtitle: Text(content),
          trailing: Column(
            children: [
              SizedBox(
                height: 20.0,
                width: 50.0,
                child: Image.network(
                    "data:image/png;base64,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"),
              ),
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
    ));
  }
}
