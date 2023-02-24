import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import './new_post_page.dart';
import '../theme/app_colors.dart';

class FreeBoardPostPage extends StatelessWidget {
  const FreeBoardPostPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
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
                  onPressed: () => {Navigator.pop(context)}),
              title: Text(
                '자유게시판',
                style: TextStyle(fontSize: 20, color: black),
              ),
              centerTitle: true,
              backgroundColor: Colors.transparent,
              elevation: 0,
            ),
          ),
        ),
        body: const PostingView(
          title: '여기는 제목 1',
          poster: '123',
          content: '여기는 내용이 나올 곳',
          publishDate: " 날짜는 01/15 12:39",
          commentCnt: 3,
          likeCnt: 10,
        ),
      ),
    );
  }
}

class PostingView extends StatelessWidget {
  final String title;
  final String poster; // 글쓴이
  final String content;
  final String? publishDate; // null 수정 예정
  final String? imageUrl;
  final int? commentCnt;
  final int? likeCnt;

  const PostingView(
      {super.key,
      required this.title,
      required this.poster,
      required this.content,
      this.publishDate,
      this.imageUrl,
      this.commentCnt,
      this.likeCnt});

  @override
  Widget build(BuildContext context) {
    var selectedItem = '';

    // 우측 상단 메뉴 - 삭제 클릭시 나오는 dialog
    void dialog() {
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return CupertinoAlertDialog(
              title: Text("작성한 댓글이 지워집니다.\n삭제하시겠습니까?"),
              actions: [
                CupertinoDialogAction(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text("취소")),
                CupertinoDialogAction(
                    onPressed: () {
                      //삭제기능 추가하기
                      Navigator.pop(context);
                    },
                    child: Text(
                      "삭제하기",
                      style: TextStyle(color: blue),
                    )),
              ],
            );
          });
    }

    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                child: ListTile(
                  dense: true,
                  contentPadding: EdgeInsets.only(left: 0.0, right: 0.0),
                  shape: Border(
                    bottom: BorderSide(
                      width: 0.5,
                      color: lightGrey,
                    ),
                  ),
                  title: Text(title),
                  subtitle: Text(poster +
                      " " +
                      (publishDate != null ? publishDate.toString() : "")),
                  trailing: PopupMenuButton(
                    //우측 상단 메뉴(수정, 삭제)
                    icon: Icon(Icons.more_vert),
                    itemBuilder: (context) {
                      return const [
                        PopupMenuItem(
                          child: Text("수정"),
                          value: 'update',
                        ),
                        PopupMenuItem(
                          child: Text("삭제"),
                          value: 'delete',
                        ),
                      ];
                    },
                    onSelected: (value) {
                      switch (value) {
                        case 'update':
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => NewPostPage()));
                          break;

                        case 'delete':
                          dialog();
                          break;
                      }
                    },
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.only(top: 10.0, bottom: 40.0),
                child: Text(content),
              ),
              Row(
                children: <Widget>[
                  Wrap(
                    spacing: 12,
                    children: [
                      likeCnt != null
                          ? Row(
                              children: [
                                Icon(
                                  Icons.thumb_up_off_alt,
                                  color: grey,
                                ),
                                Text(
                                  " " + likeCnt.toString(),
                                  style: TextStyle(
                                    fontSize: 14.0,
                                    color: grey,
                                  ),
                                ),
                              ],
                            )
                          : Row(),
                      commentCnt != null
                          ? Row(
                              children: [
                                Icon(
                                  Icons.chat_outlined,
                                  color: grey,
                                ),
                                Text(
                                  " " + commentCnt.toString(),
                                  style: TextStyle(
                                    fontSize: 14.0,
                                    color: grey,
                                  ),
                                ),
                              ],
                            )
                          : Row(),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
        Divider(thickness: 5, color: brightGrey),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            children: [
              Padding(
                // 댓글 위젯 ***************************************
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  children: [
                    ListTile(
                      contentPadding: EdgeInsets.only(left: 0.0, right: 0.0),
                      title: Row(
                        children: [
                          Text(
                            "익명1 ",
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontSize: 20.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: 4),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20.0),
                              color: brightGrey,
                            ),
                            child: Text(
                              "작성자",
                              style: TextStyle(color: grey, fontSize: 12.0),
                            ),
                          ),
                        ],
                      ),
                      subtitle: Text(
                        "플러터 코딩중",
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                            color: Colors.black.withOpacity(0.6),
                            fontSize: 15.0),
                      ),
                    ),
                    Row(
                      children: [
                        Expanded(
                          flex: 7,
                          child: Text(
                            "01/15 12:39",
                            style: TextStyle(color: lightGrey),
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: commentCnt != null
                              ? Row(
                                  children: [
                                    Icon(
                                      Icons.chat_outlined,
                                      color: grey,
                                    ),
                                    Text(
                                      " " + commentCnt.toString(),
                                      style: TextStyle(
                                        fontSize: 14.0,
                                        color: grey,
                                      ),
                                    ),
                                  ],
                                )
                              : Row(),
                        ),
                        Expanded(
                          flex: 1,
                          child: likeCnt != null
                              ? Row(
                                  children: [
                                    Icon(
                                      Icons.thumb_up_off_alt,
                                      color: grey,
                                    ),
                                    Text(
                                      " " + likeCnt.toString(),
                                      style: TextStyle(
                                        fontSize: 14.0,
                                        color: grey,
                                      ),
                                    ),
                                  ],
                                )
                              : Row(),
                        ),
                      ],
                    )
                  ],
                ),
              ),
              Padding(
                // 대댓글 위젯 *********************************************************
                padding: EdgeInsets.only(top: 10.0, bottom: 10.0, left: 40.0),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5.0),
                    color: whiteGrey,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      children: [
                        // 대댓글 Listtile 2개 들어갈 자리
                        ListTile(
                          contentPadding:
                              EdgeInsets.only(left: 0.0, right: 0.0),
                          title: Text(
                            "익명2",
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontSize: 20.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          subtitle: Text(
                            "플러터는 징역",
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                                color: Colors.black.withOpacity(0.6),
                                fontSize: 15.0),
                          ),
                        ),
                        Row(
                          children: [
                            Expanded(
                              flex: 7,
                              child: Text(
                                "01/15 12:39",
                                style: TextStyle(color: lightGrey),
                              ),
                            ),
                            Expanded(
                              flex: 1,
                              child: commentCnt != null
                                  ? Row(
                                      children: [
                                        Icon(
                                          Icons.chat_outlined,
                                          color: grey,
                                        ),
                                        Text(
                                          " " + commentCnt.toString(),
                                          style: TextStyle(
                                            fontSize: 14.0,
                                            color: grey,
                                          ),
                                        ),
                                      ],
                                    )
                                  : Row(),
                            ),
                            Expanded(
                              flex: 1,
                              child: likeCnt != null
                                  ? Row(
                                      children: [
                                        Icon(
                                          Icons.thumb_up_off_alt,
                                          color: grey,
                                        ),
                                        Text(
                                          " " + likeCnt.toString(),
                                          style: TextStyle(
                                            fontSize: 14.0,
                                            color: grey,
                                          ),
                                        ),
                                      ],
                                    )
                                  : Row(),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
