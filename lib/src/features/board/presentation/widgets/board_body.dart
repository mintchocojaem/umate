part of 'board_tab.dart';

class BoardBody<P extends Post> extends ConsumerWidget with DateTimeFormatter {
  final Board<P> board;
  final List<PostTagItem> Function(P data) postTagItems;
  final Future<void> Function() onFetch;
  final Future<void> Function(int currentPage) onFetchMore;
  final Function(int index) onTapPost;

  BoardBody({
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
    bool isFetching = false;

    return NotificationListener<ScrollNotification>(
      onNotification: (notification) {
        final screenHeight = MediaQuery.of(context).size.height;
        final bool isEndPosition = (notification.metrics.pixels >=
                notification.metrics.maxScrollExtent - (screenHeight * 0.2) &&
            notification.metrics.pixels <=
                notification.metrics.maxScrollExtent);

        if (isEndPosition && board.hasNext) {
          if (isFetching) return true;
          isFetching = true;
          onFetchMore(board.page + 1).whenComplete(() {
            isFetching = false;
          });
        }
        return true;
      },
      child: OrbRefreshIndicator(
        onRefresh: () async {
          return onFetch();
        },
        child: ListView.builder(
          clipBehavior: Clip.none,
          shrinkWrap: true,
          itemCount: (board.content.length + 1),
          itemBuilder: (context, index) {
            if (index == board.content.length && board.hasNext) {
              return const OrbShimmerContent();
            } else if (index == board.content.length) {
              return const SizedBox();
            }

            final postPreviewCard = PostPreviewCard(
              title: board.content[index].title,
              content: board.content[index].body,
              author: board.content[index].author,
              duration: dateFormatToRelative(board.content[index].createdAt),
              tags: postTagItems(board.content[index]),
              imageUrl: board.content[index].images.firstOrNull?.thumbnailUrl,
              onTap: () {
                onTapPost(index);
              },
            );

            if (index == 0) {
              return Column(
                children: [
                  Column(
                    children: [
                      const SizedBox(height: 16),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          OrbText(
                            "전체 ${board.totalElements}",
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
                  postPreviewCard,
                ],
              );
            }
            return postPreviewCard;
          },
        ),
      ),
    );
  }
}
