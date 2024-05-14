import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/services/router/router_service.dart';
import '../../../../core/utils/date_time_formatter.dart';
import '../../../../design_system/orb/orb.dart';
import '../../domain/models/board.dart';
import '../../domain/models/petition_post.dart';
import '../../domain/models/petition_status.dart';
import '../../domain/models/post_sort.dart';
import '../../petition_dependency_injections.dart';
import '../providers/states/board_state.dart';
import '../widgets/category_bar.dart';
import '../widgets/post_preview_card.dart';

ScrollController? _scrollController;

Future<void> scrollUpPetitionBoard() async {
  if (_scrollController != null && _scrollController!.hasClients) {
    await _scrollController!.animateTo(
      0,
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeInOut,
    );
  }
}

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

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _scrollController = ScrollController();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _scrollController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    ref.listen(
      petitionBoardProvider,
      (prev, next) {
        if (next is BoardFailureState && !next.isCanceled) {
          ScaffoldMessenger.of(context).showSnackBar(
            OrbSnackBar(
              message: next.message,
              type: OrbSnackBarType.error,
            ),
          );
        }
      },
    );

    final petitionBoardState = ref.watch(petitionBoardProvider);

    final theme = OrbTheme.of(context);
    final currentPalette = theme.getCurrentPalette(context);
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        shape: const CircleBorder(),
        onPressed: () async {
          ref.read(routerServiceProvider).pushNamed(
                AppRoute.petitionWrite.name,
              );
        },
        backgroundColor: currentPalette.surfaceDim,
        child: Icon(
          Icons.edit,
          color: currentPalette.onSecondary,
        ),
      ),
      body: Container(
        color: currentPalette.surfaceBright,
        child: NestedScrollView(
          controller: _scrollController,
          floatHeaderSlivers: true,
          headerSliverBuilder: (context, innerBoxIsScrolled) {
            return [
              SliverAppBar(
                automaticallyImplyLeading: false,
                floating: true,
                snap: true,
                elevation: 0,
                backgroundColor: Colors.transparent,
                surfaceTintColor: Colors.transparent,
                expandedHeight: 64,
                flexibleSpace: Container(
                  decoration: BoxDecoration(
                    color: theme.scaffoldTheme.backgroundColor,
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
                        ref.read(petitionBoardCategoryProvider),
                      ),
                      categoryList: [
                        for (final category in categoryList) category.korean,
                      ],
                      onIndexChanged: (index) {
                        ref
                            .read(petitionBoardCategoryProvider.notifier)
                            .changeCategory(
                              categoryList[index],
                            );
                        _scrollController?.jumpTo(0);
                      },
                    ),
                  ),
                ),
              ),
            ];
          },
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: switch (petitionBoardState) {
              BoardSuccessState<PetitionPost> success => success
                      .board.content.isEmpty
                  ? Center(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const OrbText(
                            "연관된 게시글이 존재하지 않아요",
                            type: OrbTextType.bodyLarge,
                          ),
                          const SizedBox(height: 8),
                          OrbFilledButton(
                            text: "다시 불러오기",
                            buttonSize: OrbButtonSize.compact,
                            buttonRadius: OrbButtonRadius.small,
                            buttonTextType: OrbButtonTextType.small,
                            buttonType: OrbButtonType.secondary,
                            onPressed: () async {
                              await ref
                                  .read(petitionBoardProvider.notifier)
                                  .getPetitionBoard(
                                    sort: ref.read(petitionBoardSortProvider),
                                    status:
                                        ref.read(petitionBoardCategoryProvider),
                                    isFetchMore: true,
                                  );
                            },
                          ),
                        ],
                      ),
                    )
                  : PetitionBoardBody(
                      board: success.board,
                    ),
              _ => ListView.builder(
                  shrinkWrap: true,
                  itemCount: 5,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    return const OrbShimmerContent();
                  },
                ),
            },
          ),
        ),
      ),
    );
  }
}

class PetitionBoardBody extends ConsumerStatefulWidget {
  final Board<PetitionPost> board;

  const PetitionBoardBody({
    super.key,
    required this.board,
  });

  @override
  ConsumerState<ConsumerStatefulWidget> createState() {
    return _PetitionBoardBodyState();
  }
}

class _PetitionBoardBodyState extends ConsumerState<PetitionBoardBody>
    with DateTimeFormatter {
  final List<PostSort> sortList = [
    PostSort(type: PostSortType.createdAt, order: PostSortOrder.desc),
    PostSort(type: PostSortType.viewCount, order: PostSortOrder.desc),
  ];

  @override
  Widget build(BuildContext context) {
    final theme = OrbTheme.of(context);
    final currentPalette = theme.getCurrentPalette(context);

    return NotificationListener<ScrollNotification>(
      onNotification: (notification) {
        if (notification is ScrollEndNotification) {
          if (notification.metrics.pixels >=
                  notification.metrics.maxScrollExtent * 0.9 &&
              widget.board.hasNext) {
            ref.read(petitionBoardProvider.notifier).getPetitionBoard(
                  sort: ref.read(petitionBoardSortProvider),
                  status: ref.read(petitionBoardCategoryProvider),
                  page: widget.board.page + 1,
                  isFetchMore: true,
                );
          }
        }
        return true;
      },
      child: RefreshIndicator(
        color: currentPalette.secondary,
        backgroundColor: currentPalette.onPrimary,
        onRefresh: () {
          return ref.read(petitionBoardProvider.notifier).getPetitionBoard(
                sort: ref.read(petitionBoardSortProvider),
                status: ref.read(petitionBoardCategoryProvider),
              );
        },
        child: SingleChildScrollView(
          clipBehavior: Clip.none,
          child: Column(
            children: [
              Column(
                children: [
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      OrbText(
                        "전체 ${widget.board.totalElements}",
                        type: OrbTextType.bodyMedium,
                      ),
                      DropdownButton(
                        value: ref.read(petitionBoardSortProvider),
                        items: [
                          for (final sort in sortList)
                            DropdownMenuItem(
                              value: sort,
                              child: OrbText(
                                sort.type.displayName,
                                type: OrbTextType.bodyMedium,
                              ),
                            ),
                        ],
                        onChanged: (value) {
                          if (value != null) {
                            ref
                                .read(petitionBoardSortProvider.notifier)
                                .changeSort(value);
                          }
                        },
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                ],
              ),
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: widget.board.content.length + 1,
                itemBuilder: (context, index) {
                  if (index == widget.board.content.length &&
                      widget.board.hasNext) {
                    return const OrbShimmerContent();
                  } else if (index == widget.board.content.length) {
                    return const SizedBox();
                  }

                  return PostPreviewCard(
                    title: widget.board.content[index].title,
                    content: widget.board.content[index].body,
                    author: widget.board.content[index].author,
                    duration: dateFormatToRelative(
                        widget.board.content[index].createdAt),
                    tags: [
                      PostTagItem(
                        title: widget.board.content[index].status.korean,
                      ),
                      PostTagItem(
                        title: dateFormatToRemaining(
                          widget.board.content[index].expiresAt,
                        ),
                      ),
                      PostTagItem(
                        title: "참여 ${widget.board.content[index].agreeCount}명",
                      ),
                    ],
                    imageUrl: widget
                        .board.content[index].images.firstOrNull?.thumbnailUrl,
                    onTap: () {
                      ref.read(routerServiceProvider).pushNamed(
                        AppRoute.petitionPost.name,
                        pathParameters: {
                          "id": widget.board.content[index].id.toString(),
                        },
                      );
                    },
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
