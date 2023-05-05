import 'package:danvery/core/theme/app_text_theme.dart';
import 'package:danvery/core/theme/palette.dart';
import 'package:danvery/domain/board/petition_board/model/petition_board_model.dart';
import 'package:danvery/domain/board/post/petition_post/model/petition_post_model.dart';
import 'package:danvery/routes/app_routes.dart';
import 'package:danvery/ui/pages/main/my_page/controller/mypage_page_controller.dart';
import 'package:danvery/ui/widgets/app_bar/transparent_app_bar.dart';
import 'package:danvery/ui/widgets/board/pettition_card.dart';
import 'package:danvery/ui/widgets/board/post_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MyPagePostPage extends GetView<MyPagePageController> {
  const MyPagePostPage({super.key});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    controller.getUserPostListWithRefresh(true);
    controller.selectedTabIndex.value = 0;
    return DefaultTabController(
      initialIndex: 0,
      length: controller.myPagePostType.length,
      child: Scaffold(
        backgroundColor: Palette.pureWhite,
        appBar: TransparentAppBar(
          isDarkMode: Get.isDarkMode,
          title: controller.myPagePostType[controller.selectedTabIndex.value].title
          ,
          automaticallyImplyLeading: true,
          onPressedLeading: () => Get.back(),
        ),
        body: Column(
          children: [
            if(controller.myPagePostType.contains(MyPagePostType.petition)) DecoratedBox(
              decoration: BoxDecoration(
                //This is for bottom border that is needed
                border:
                    Border(bottom: BorderSide(color: Palette.white, width: 2)),
              ),
              child: TabBar(
                onTap: (index) {
                  controller.selectedTabIndex.value = index;
                },
                indicatorColor: Palette.blue,
                unselectedLabelColor: Palette.grey,
                labelColor: Palette.blue,
                tabs: const [
                  Tab(
                    child: Text(
                      "자유게시판",
                      style: regularStyle,
                    ),
                  ),
                  Tab(
                    child: Text(
                      "청원게시판",
                      style: regularStyle,
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: TabBarView(
                children: [
                  Obx(
                    () => controller.isLoadGeneralPostList.value
                        ? ListView.builder(
                            key: const PageStorageKey("generalPostList"),
                            controller: controller.generaPostListScroller,
                            shrinkWrap: true,
                            padding: const EdgeInsets.only(
                                top: 8, bottom: 8, left: 16, right: 16),
                            itemCount: controller.userGeneralPostList.value
                                    .generalPosts.length +
                                1,
                            itemBuilder: (BuildContext context, int index) {
                              final userGeneralPostList =
                                  controller.userGeneralPostList.value;
                              if (index ==
                                  userGeneralPostList.generalPosts.length) {
                                if (userGeneralPostList.last) {
                                  return const SizedBox();
                                } else {
                                  return const Padding(
                                    padding: EdgeInsets.all(16.0),
                                    child: Center(
                                      child: CircularProgressIndicator(),
                                    ),
                                  );
                                }
                              }
                              return Container(
                                color: Palette.pureWhite,
                                child: Column(
                                  children: [
                                    PostCard(
                                      nickname: userGeneralPostList
                                          .generalPosts[index].author,
                                      title: userGeneralPostList
                                          .generalPosts[index].title,
                                      subtitle: userGeneralPostList
                                          .generalPosts[index].body,
                                      publishDate: userGeneralPostList
                                          .generalPosts[index].createdAt,
                                      commentCount: userGeneralPostList
                                          .generalPosts[index].commentCount,
                                      likeCount: userGeneralPostList
                                          .generalPosts[index].likes,
                                      imageUrl: userGeneralPostList
                                              .generalPosts[index].files
                                              .map((e) =>
                                                  e.mimeType.contains('image')
                                                      ? e.thumbnailUrl
                                                      : null)
                                              .whereType<String>()
                                              .isNotEmpty
                                          ? userGeneralPostList
                                              .generalPosts[index].files
                                              .map((e) =>
                                                  e.mimeType.contains('image')
                                                      ? e.thumbnailUrl
                                                      : null)
                                              .whereType<String>()
                                              .first
                                          : null,
                                      onTap: () {
                                        Get.toNamed(Routes.post,
                                            arguments: userGeneralPostList
                                                .generalPosts[index].id);
                                      },
                                    ),
                                    Divider(
                                      color: Palette.lightGrey,
                                      thickness: 1,
                                    ),
                                  ],
                                ),
                              );
                            },
                          )
                        : const SizedBox(
                            height: 400,
                            child: Center(
                              child: CircularProgressIndicator(),
                            ),
                          ),
                  ),
                  Obx(
                    () => controller.isLoadPetitionPostList.value
                        ? controller.userPetitionPostList.value.petitionPosts
                                .isEmpty
                            ? CustomScrollView(
                                physics: const AlwaysScrollableScrollPhysics(),
                                slivers: [
                                  SliverFillRemaining(
                                    hasScrollBody: false,
                                    child: Center(
                                      child: Text(
                                        '연관된 게시물이 존재하지 않습니다',
                                        style: smallTitleStyle.copyWith(
                                            color: Palette.grey),
                                      ),
                                    ),
                                  ),
                                ],
                              )
                            : ListView.builder(
                                key: const PageStorageKey("petitionPostList"),
                                controller: controller.petitionPostListScroller,
                                physics: const AlwaysScrollableScrollPhysics(),
                                itemCount: controller.userPetitionPostList.value
                                        .petitionPosts.length +
                                    1,
                                itemBuilder: (BuildContext context, int index) {
                                  final PetitionBoardModel
                                      userPetitionPostList =
                                      controller.userPetitionPostList.value;
                                  if (index ==
                                      userPetitionPostList
                                          .petitionPosts.length) {
                                    if (userPetitionPostList.last) {
                                      return const SizedBox();
                                    } else {
                                      return const Padding(
                                        padding: EdgeInsets.all(16.0),
                                        child: Center(
                                          child: CircularProgressIndicator(),
                                        ),
                                      );
                                    }
                                  }
                                  return Padding(
                                    padding: const EdgeInsets.only(
                                        top: 8.0,
                                        bottom: 8,
                                        left: 16,
                                        right: 16),
                                    child: PetitionCard(
                                      tag: userPetitionPostList
                                          .petitionPosts[index].tag.first.name,
                                      title: userPetitionPostList
                                          .petitionPosts[index].title,
                                      createdAt: userPetitionPostList
                                          .petitionPosts[index].createdAt,
                                      expiredAt: userPetitionPostList
                                          .petitionPosts[index].expiresAt,
                                      agreeCount:
                                          "${userPetitionPostList.petitionPosts[index].agreeCount}명",
                                      status: userPetitionPostList
                                          .petitionPosts[index].status,
                                      onTap: () {
                                        Get.toNamed(Routes.petition,
                                                arguments: userPetitionPostList
                                                    .petitionPosts[index].id)
                                            ?.then((value) {
                                          if (value != null) {
                                            final petitionPostModel =
                                                value as PetitionPostModel;
                                            userPetitionPostList
                                                    .petitionPosts[index] =
                                                petitionPostModel;
                                          }
                                        });
                                      },
                                    ),
                                  );
                                })
                        : const Center(
                            child: CircularProgressIndicator(),
                          ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
