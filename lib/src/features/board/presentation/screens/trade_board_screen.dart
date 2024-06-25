import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:umate/src/core/utils/extensions.dart';

import '../../../../core/utils/date_time_formatter.dart';

import '../view_models/trade_board_view_model.dart';
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
    final tradeBoard = ref.watch(tradeBoardViewModelProvider);

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        shape: const CircleBorder(),
        onPressed: () {},
        backgroundColor: context.palette.surfaceDim,
        child: Icon(
          Icons.edit,
          color: context.palette.onSecondary,
        ),
      ),
      body: BoardTab(
        board: tradeBoard,
        onFetch: () async {
          ref.read(tradeBoardViewModelProvider.notifier).fetch();
        },
        onFetchMore: (currentPage) async {
          ref.read(tradeBoardViewModelProvider.notifier).fetchMore(
                page: currentPage,
              );
        },
        postTagItems: (post) => [
          PostTagItem(
            title: post.status,
          ),
          PostTagItem(
            title: post.tradePlace,
          ),
        ],
        onTapPost: (post) {},
      ),
    );
  }
}
