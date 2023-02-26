import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../theme/app_colors.dart';
import '../../theme/app_text_theme.dart';
import '../../widgets/card/notice_card.dart';
import '../../widgets/card/post_card.dart';

class GeneralBoardPage extends GetView {
  const GeneralBoardPage({super.key});

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
              ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  padding: const EdgeInsets.only(top: 10, bottom: 10),
                  itemCount: 2,
                  itemBuilder: (BuildContext context, int index) {
                    return const NoticeCard(
                        category: "공지",
                        title: "내용",
                        commentCount: 0,
                        likeCount: 0
                    );
                  }
              ),
              ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  padding: const EdgeInsets.only(top: 10, bottom: 10),
                  itemCount: 10,
                  itemBuilder: (BuildContext context, int index) {
                    return const PostCard(
                      title: '제목',
                      subtitle: '내용',
                      publishDate: '1분 전',
                      commentCount: 0,
                      likeCount: 0,
                    );
                  }
              )
            ],
          ),
        ),
      ),
    );
  }
}

