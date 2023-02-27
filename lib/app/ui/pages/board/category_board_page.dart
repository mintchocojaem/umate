import 'package:danvery/app/ui/widgets/app_bar/transparent_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../theme/app_colors.dart';
import '../../theme/app_text_theme.dart';
import '../../widgets/card/notice_card.dart';
import '../../widgets/card/post_card.dart';

class CategoryBoardPage extends GetView {
  const CategoryBoardPage({super.key});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    return SingleChildScrollView(
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
    );
  }
}

