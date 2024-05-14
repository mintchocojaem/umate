import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/services/router/router_service.dart';
import '../../../../core/utils/date_time_formatter.dart';
import '../../../../design_system/orb/orb.dart';
import '../../domain/models/board.dart';
import '../../domain/models/notice_post.dart';
import '../../domain/models/post_sort.dart';
import '../../petition_dependency_injections.dart';
import '../providers/states/board_state.dart';
import '../widgets/post_preview_card.dart';

ScrollController? _scrollController;

Future<void> scrollUpNoticeBoard() async {
  if (_scrollController != null && _scrollController!.hasClients) {
    await _scrollController!.animateTo(
      0,
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeInOut,
    );
  }
}

class NoticeBoardScreen extends ConsumerStatefulWidget {
  const NoticeBoardScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() {
    // TODO: implement createState
    return _NoticeBoardScreenState();
  }
}

class _NoticeBoardScreenState extends ConsumerState<NoticeBoardScreen>
    with DateTimeFormatter {
  final List<PostSort> _sortList = [
    PostSort(type: PostSortType.createdAt, order: PostSortOrder.desc),
    PostSort(type: PostSortType.viewCount, order: PostSortOrder.desc),
  ];

  @override
  void initState() {
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
      noticeBoardProvider,
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

    final noticeBoardState = ref.watch(noticeBoardProvider);

    final theme = OrbTheme.of(context);
    final currentPalette = theme.getCurrentPalette(context);
    return Container(
      color: currentPalette.surfaceBright,
      child: RefreshIndicator(
        color: currentPalette.secondary,
        backgroundColor: currentPalette.onPrimary,
        onRefresh: () {
          return ref.read(noticeBoardProvider.notifier).getNoticeBoard(
                sort: ref.read(petitionBoardSortProvider),
              );
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: switch (noticeBoardState) {
            BoardSuccessState<NoticePost> success =>
              success.board.content.isEmpty
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
                                  .read(noticeBoardProvider.notifier)
                                  .getNoticeBoard(
                                    sort: ref.read(petitionBoardSortProvider),
                                    isFetchMore: true,
                                  );
                            },
                          ),
                        ],
                      ),
                    )
                  : NoticeBoardBody(
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
    );
  }
}

class NoticeBoardBody extends ConsumerStatefulWidget {
  final Board<NoticePost> board;

  const NoticeBoardBody({
    super.key,
    required this.board,
  });

  @override
  ConsumerState<ConsumerStatefulWidget> createState() {
    // TODO: implement createState
    return _NoticeBoardBodyState();
  }
}

class _NoticeBoardBodyState extends ConsumerState<NoticeBoardBody>
    with DateTimeFormatter {
  final List<PostSort> _sortList = [
    PostSort(type: PostSortType.createdAt, order: PostSortOrder.desc),
    PostSort(type: PostSortType.viewCount, order: PostSortOrder.desc),
  ];

  late final ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels >=
              _scrollController.position.maxScrollExtent * 0.9 &&
          widget.board.hasNext) {
        ref.read(noticeBoardProvider.notifier).getNoticeBoard(
              sort: ref.read(noticeBoardSortProvider),
              page: widget.board.page + 1,
              isFetchMore: true,
            );
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    final theme = OrbTheme.of(context);
    final currentPalette = theme.getCurrentPalette(context);

    return NotificationListener<ScrollNotification>(
      onNotification: (notification) {
        if (notification is ScrollEndNotification) {
          if (_scrollController.position.pixels >=
              _scrollController.position.maxScrollExtent * 0.9 &&
              widget.board.hasNext) {
            ref.read(noticeBoardProvider.notifier).getNoticeBoard(
                  sort: ref.read(noticeBoardSortProvider),
                  page: widget.board.page + 1,
                  isFetchMore: true,
                );
          }
        }
        return false;
      },
      child: RefreshIndicator(
        color: currentPalette.secondary,
        backgroundColor: currentPalette.onPrimary,
        onRefresh: () {
          return ref.read(noticeBoardProvider.notifier).getNoticeBoard(
                sort: ref.read(petitionBoardSortProvider),
              );
        },
        child: SingleChildScrollView(
          clipBehavior: Clip.none,
          controller: _scrollController,
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
                        value: ref.read(noticeBoardSortProvider),
                        items: [
                          for (final sort in _sortList)
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
                                .read(noticeBoardSortProvider.notifier)
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
                itemBuilder: (_, index) {
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
                    duration:
                        dateFormatToRelative(widget.board.content[index].createdAt),
                    tags: [],
                    imageUrl: widget
                        .board.content[index].images.firstOrNull?.thumbnailUrl,
                    onTap: () {
                      ref.read(routerServiceProvider).pushNamed(
                        AppRoute.noticePost.name,
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
