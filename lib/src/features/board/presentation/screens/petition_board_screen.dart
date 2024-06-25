import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:umate/src/core/utils/extensions.dart';

import '../../../../core/services/router/router_service.dart';
import '../../../../core/utils/date_time_formatter.dart';
import '../../domain/models/petition_status.dart';
import '../view_models/petition_board_view_model.dart';
import '../widgets/category_bar.dart';
import '../widgets/post_preview_card.dart';
import '../widgets/board_tab.dart';

class PetitionBoardScreen extends ConsumerStatefulWidget {
  const PetitionBoardScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() {
    // TODO: implement createState
    return _PetitionBoardScreenState();
  }
}

class _PetitionBoardScreenState extends ConsumerState<PetitionBoardScreen>
    with DateTimeFormatter {
  final List<PetitionStatus> categoryList = [
    PetitionStatus.active,
    PetitionStatus.waiting,
    PetitionStatus.answered,
    PetitionStatus.expired,
  ];

  final ScrollController _scrollController = ScrollController();

  @override
  void dispose() {
    // TODO: implement dispose
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    final petitionBoard = ref.watch(petitionBoardViewModelProvider);

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        shape: const CircleBorder(),
        onPressed: () {
          ref.read(routerServiceProvider).pushNamed(
                AppRoute.writePetition.name,
              );
        },
        backgroundColor: context.palette.surfaceDim,
        child: Icon(
          Icons.edit,
          color: context.palette.onSecondary,
        ),
      ),
      body: NestedScrollView(
        controller: _scrollController,
        floatHeaderSlivers: true,
        headerSliverBuilder: (context, innerBoxIsScrolled) {
          return [
            SliverAppBar(
              automaticallyImplyLeading: false,
              floating: true,
              snap: true,
              backgroundColor: Colors.transparent,
              surfaceTintColor: Colors.transparent,
              flexibleSpace: Container(
                decoration: BoxDecoration(
                  color: context.palette.background,
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(20),
                    bottomRight: Radius.circular(20),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      offset: const Offset(0, 2),
                      blurRadius: 4,
                    ),
                  ],
                ),
                child: Center(
                  child: CategoryBar(
                    currentIndex: categoryList.indexOf(
                      ref.watch(petitionStatusProvider),
                    ),
                    categoryList: [
                      for (final category in categoryList) category.korean,
                    ],
                    onIndexChanged: (index) {
                      ref
                          .read(petitionStatusProvider.notifier)
                          .update((state) => categoryList[index]);
                      _scrollController.jumpTo(0);
                    },
                  ),
                ),
              ),
            ),
          ];
        },
        body: BoardTab(
          board: petitionBoard,
          onFetch: () async {
            await ref.read(petitionBoardViewModelProvider.notifier).fetch();
          },
          onFetchMore: (currentPage) async {
            await ref.read(petitionBoardViewModelProvider.notifier).fetchMore(
                  page: currentPage,
                );
          },
          postTagItems: (post) => [
            PostTagItem(
              title: post.status.korean,
            ),
            PostTagItem(
              title: dateFormatToRemaining(
                post.expiresAt,
              ),
            ),
            PostTagItem(
              title: "참여 ${post.agreeCount}명",
            ),
          ],
          onTapPost: (post) {
            ref.read(routerServiceProvider).pushNamed(
              AppRoute.petitionPost.name,
              pathParameters: {
                'id': post.id.toString(),
              },
            );
          },
        ),
      ),
    );
  }
}
