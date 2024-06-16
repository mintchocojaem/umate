import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:umate/src/core/utils/extensions.dart';

import '../../../../core/utils/date_time_formatter.dart';
import '../../../../design_system/orb/orb.dart';
import '../../domain/models/board.dart';
import '../../domain/models/post.dart';
import '../../domain/models/post_sort.dart';
import 'post_preview_card.dart';

part 'board_body.dart';

class BoardTab<P extends Post> extends ConsumerWidget with DateTimeFormatter {
  final AsyncValue<Board<P>> board;
  final List<PostTagItem> Function(P data) postTagItems;
  final Future<void> Function() onFetch;
  final Future<void> Function(int currentPage) onFetchMore;
  final Function(int index) onTapPost;

  BoardTab({
    super.key,
    required this.board,
    required this.postTagItems,
    required this.onFetch,
    required this.onFetchMore,
    required this.onTapPost,
  });

  final List<PostSort> sortList = [
    PostSort(type: PostSortType.createdAt, order: PostSortOrder.desc),
    PostSort(type: PostSortType.viewCount, order: PostSortOrder.desc),
  ];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // TODO: implement build
    return Container(
      color: context.palette.surfaceBright,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: board.when(
          skipLoadingOnReload: false,
          skipLoadingOnRefresh: false,
          data: (data) => data.content.isEmpty
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
                          await onFetch();
                        },
                      ),
                    ],
                  ),
                )
              : BoardBody(
                  board: data,
                  postTagItems: postTagItems,
                  onFetch: onFetch,
                  onFetchMore: onFetchMore,
                  onTapPost: onTapPost,
                ),
          loading: () => ListView.builder(
            shrinkWrap: true,
            itemCount: 5,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              return const OrbShimmerContent();
            },
          ),
          error: (error, stackTrace) => Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const OrbText(
                  "게시글을 불러오는 중 오류가 발생했어요",
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
                    await onFetch();
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
