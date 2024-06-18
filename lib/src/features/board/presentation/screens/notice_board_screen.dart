import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/services/router/router_service.dart';
import '../../../../core/utils/date_time_formatter.dart';
import '../providers/notice_board_provider.dart';
import '../widgets/board_tab.dart';

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
    final noticeBoard = ref.watch(noticeBoardProvider);

    return BoardTab(
      board: noticeBoard,
      onFetch: () async {
        await ref.read(noticeBoardProvider.notifier).fetch();
      },
      onFetchMore: (currentPage) async {
        await ref.read(noticeBoardProvider.notifier).fetchMore(
              page: currentPage,
            );
      },
      postTagItems: (post) => [],
      onTapPost: (post) {
        ref.read(routerServiceProvider).pushNamed(
          AppRoute.noticePost.name,
          pathParameters: {
            'id': post.id.toString(),
          },
        );
      },
    );
  }
}
