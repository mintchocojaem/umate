import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../theme/app_colors.dart';
import '../theme/app_text_theme.dart';
import '../widgets/notice_card.dart';
import '../widgets/post_card.dart';

class BoardPage extends GetView {
  const BoardPage({super.key});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    return Scaffold(
      backgroundColor: white,
      appBar: AppBar(
        centerTitle: true,
        toolbarHeight: 80,
        backgroundColor: transparent,
        title: Text(
          "자유게시판",
          style: titleStyle.copyWith(color: black),
        ),
        elevation: 0,
        actions: [
          IconButton(onPressed: (){}, icon: Icon(Icons.search, color: grey,)),
          const SizedBox(width: 8,),
          IconButton(onPressed: (){}, icon: Icon(Icons.post_add_outlined, color: grey,)),
          const SizedBox(width: 16,)
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(right: 16, left: 16, top: 16, bottom: 16),
          child: Column(
            children: [
              ListView(
                padding: EdgeInsets.zero,
                shrinkWrap: true,
                children: const <Widget>[
                  NoticeCard(
                      category: "공지",
                      title: "셔틀버스 시간 변경 안내",
                      commentCount: 8,
                      likeCount: 9),
                  NoticeCard(
                      category: "인기",
                      title: "오늘",
                      imageCount: 2,
                      commentCount: 2,
                      likeCount: 24),
                ],
              ),
              const SizedBox(height: 16,),
              ListView(
                padding: EdgeInsets.zero,
                shrinkWrap: true,
                children: const [
                  PostCard(
                    title: '여기는 제목 1',
                    subtitle: '여기는 내용이 나올 곳 ',
                    publishDate: '20분 전',
                    thumbnailUrl:
                    'data:image/jpeg;base64,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',
                    imageCount: 1,
                    commentCount: 3,
                    likeCount: 10,
                  ),
                  PostCard(
                    title: '제목123',
                    subtitle: '부제목인데 만약에 길게 나온다면??? 내용이 나와서 길게 나올 수 있음',
                    publishDate: 'Feb 26',
                    commentCount: 3,
                    likeCount: 10,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

