import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/services/router/router_service.dart';
import '../../../../core/utils/date_time_formatter.dart';
import '../../../../design_system/orb/orb.dart';
import '../../domain/model/petition_board.dart';
import '../../domain/model/post_sort.dart';
import '../provider/petition_board_provider.dart';
import 'post_preview_card.dart';

class PetitionBoardBody extends ConsumerStatefulWidget {
  final PetitionBoard petitionBoard;

  const PetitionBoardBody({
    super.key,
    required this.petitionBoard,
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

  bool isFetching = false;

  @override
  Widget build(BuildContext context) {
    return NotificationListener<ScrollNotification>(
      onNotification: (notification) {
        final screenHeight = MediaQuery.of(context).size.height;
        final bool isEnd = notification is ScrollEndNotification &&
            (notification.metrics.pixels >=
                notification.metrics.maxScrollExtent - (screenHeight * 0.2));

        if (isEnd && widget.petitionBoard.hasNext && !isFetching) {
          isFetching = true;
          ref
              .read(petitionBoardProvider.notifier)
              .getPetitionBoard(
                page: widget.petitionBoard.page + 1,
              )
              .whenComplete(() {
            isFetching = false;
          });
        }
        return true;
      },
      child: RefreshIndicator(
        color: OrbThemeData.of(context).palette.primary,
        backgroundColor: OrbThemeData.of(context).palette.onPrimary,
        onRefresh: () async {
          ref.read(petitionBoardProvider.notifier).getPetitionBoard();
        },
        child: ListView.builder(
          clipBehavior: Clip.none,
          shrinkWrap: true,
          itemCount: (widget.petitionBoard.content.length + 1),
          itemBuilder: (context, index) {
            if (index == widget.petitionBoard.content.length &&
                widget.petitionBoard.hasNext) {
              return const OrbShimmerContent();
            } else if (index == widget.petitionBoard.content.length) {
              return const SizedBox();
            }

            return Column(
              children: [
                if (index == 0)
                  Column(
                    children: [
                      const SizedBox(height: 16),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          OrbText(
                            "전체 ${widget.petitionBoard.totalElements}",
                            type: OrbTextType.bodyMedium,
                          ),
                          DropdownButton(
                            value: sortList.first,
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
                            onChanged: (value) {},
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                    ],
                  ),
                PostPreviewCard(
                  title: widget.petitionBoard.content[index].title,
                  content: widget.petitionBoard.content[index].body,
                  author: widget.petitionBoard.content[index].author,
                  duration: dateFormatToRelative(
                      widget.petitionBoard.content[index].createdAt),
                  tags: [
                    PostTagItem(
                      title: widget.petitionBoard.content[index].status.korean,
                    ),
                    PostTagItem(
                      title: dateFormatToRemaining(
                        widget.petitionBoard.content[index].expiresAt,
                      ),
                    ),
                    PostTagItem(
                      title:
                          "참여 ${widget.petitionBoard.content[index].agreeCount}명",
                    ),
                  ],
                  imageUrl: widget.petitionBoard.content[index].images
                      .firstOrNull?.thumbnailUrl,
                  onTap: () {
                    ref.read(routerServiceProvider).pushNamed(
                      AppRoute.petitionPost.name,
                      pathParameters: {
                        "id": widget.petitionBoard.content[index].id.toString(),
                      },
                    );
                  },
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
