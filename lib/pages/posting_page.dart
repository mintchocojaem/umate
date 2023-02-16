import 'package:danvery/settings/palette.dart';
import 'package:flutter/material.dart';

class PostingPage extends StatelessWidget {
  const PostingPage({super.key});

  static const String _title = 'Flutter Code Sample';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(50.0),
          child: AppBar(
            leading: IconButton(
                icon: Icon(
                  Icons.arrow_back_ios,
                  color: Palette.black,
                ),
                onPressed: () => {Navigator.pop(context)}),
            title: Text(
              '자유게시판',
              style: TextStyle(fontSize: 20, color: Palette.black),
            ),
            centerTitle: true,
            backgroundColor: Colors.transparent,
            elevation: 0,
          ),
        ),
        body: const PostingView(
          title: '여기는 제목 1',
          poster: '123',
          content: '여기는 내용이 나올 곳',
          publishDate: " 날짜는 01/15 12:39",
          imageCnt: 1,
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
  final int? imageCnt;
  final int? commentCnt;
  final int? likeCnt;

  const PostingView(
      {super.key,
      required this.title,
      required this.poster,
      required this.content,
      this.publishDate,
      this.imageUrl,
      this.imageCnt,
      this.commentCnt,
      this.likeCnt});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 20.0),
          child: ListTile(
            shape: Border(
              bottom: BorderSide(
                width: 0.5,
                color: Palette.lightGrey,
              ),
            ),
            title: Text(title),
            subtitle: Text(poster +
                " " +
                (publishDate != null ? publishDate.toString() : "")),
            trailing: Icon(Icons.more_vert),
          ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 20.0),
          child: Text(content),
        ),
        Row(
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
                                fontSize: 20, color: Palette.lightGrey),
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
                                fontSize: 20, color: Palette.lightGrey),
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
                                fontSize: 20, color: Palette.lightGrey),
                          ),
                        ],
                      )
                    : Row(),
              ],
            ),
          ],
        ),
        Divider(thickness: 5, color: Palette.brightGrey)
      ],
    );
  }
}
