part of 'board_tab.dart';

class BoardBody<P extends Post> extends StatelessWidget with DateTimeFormatter {
  final Board<P> board;
  final List<PostTagItem> Function(P data) postTagItems;
  final Future<void> Function() onRefresh;
  final Future<void> Function() onFetch;
  final Function(P data) onTapPost;

  BoardBody({
    super.key,
    required this.board,
    required this.postTagItems,
    required this.onRefresh,
    required this.onFetch,
    required this.onTapPost,
  });

  final List<PostSort> sortList = const [
    PostSort(type: PostSortType.createdAt, order: PostSortOrder.desc),
    PostSort(type: PostSortType.viewCount, order: PostSortOrder.desc),
  ];

  @override
  Widget build(BuildContext context) {
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
          onFetch().whenComplete(() {
            isFetching = false;
          });
        }
        return true;
      },
      child: OrbRefreshIndicator(
        onRefresh: () async {
          return onRefresh();
        },
        child: BoardList(
          board: board,
          sortList: sortList,
          postItems: (index) => PostPreviewCard.image(
            title: board.content[index].title,
            content: board.content[index].body,
            author: board.content[index].author,
            duration: dateFormatToRelative(board.content[index].createdAt),
            tags: postTagItems(board.content[index]),
            imageUrl: board.content[index].images.firstOrNull?.thumbnailUrl,
            onTap: () {
              onTapPost(board.content[index]);
            },
          ),
        ),
      ),
    );
  }
}
