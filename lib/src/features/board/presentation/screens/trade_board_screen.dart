import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/utils/date_time_formatter.dart';

import '../providers/trade_board_provider.dart';
import '../widgets/board_tab.dart';
import '../widgets/post_preview_card.dart';

class TradeBoardScreen extends ConsumerStatefulWidget {
  const TradeBoardScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() {
    // TODO: implement createState
    return _TradeBoardScreenState();
  }
}

class _TradeBoardScreenState extends ConsumerState<TradeBoardScreen>
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
    final tradeBoard = ref.watch(tradeBoardProvider);

    return BoardTab(
      board: tradeBoard,
      onFetch: () async {
        //await ref.read(noticeBoardProvider.notifier).fetch();
      },
      onFetchMore: (currentPage) async {},
      postTagItems: (post) => [
        PostTagItem(
          title: post.status,
        ),
        PostTagItem(
          title: post.tradePlace,
        ),
      ],
      onTapPost: (post){},
    );
  }
}
