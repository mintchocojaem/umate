import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:umate/src/core/utils/extensions.dart';

import '../../../../core/services/router/router_service.dart';
import '../../../../core/utils/date_time_formatter.dart';

import '../view_models/bear_eats_board_view_model.dart';
import '../widgets/board_tab.dart';
import '../widgets/post_preview_card.dart';

class BearEatsBoardScreen extends ConsumerStatefulWidget {
  const BearEatsBoardScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() {
    // TODO: implement createState
    return _BearEatsBoardScreenState();
  }
}

class _BearEatsBoardScreenState extends ConsumerState<BearEatsBoardScreen>
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
    final bearEatsBoard = ref.watch(bearEatsBoardViewModelProvider);

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
        board: bearEatsBoard,
        onFetch: () async {
          await ref.read(bearEatsBoardViewModelProvider.notifier).fetch();
        },
        onFetchMore: (currentPage) async {
          await ref.read(bearEatsBoardViewModelProvider.notifier).fetchMore(
                page: currentPage,
              );
        },
        postTagItems: (post) => [
          PostTagItem(
            title: '${post.recruitedCount}명 모집',
          ),
          PostTagItem(
            title: post.deliveryPlace,
          ),
        ],
        onTapPost: (post) {},
      ),
    );
  }
}
