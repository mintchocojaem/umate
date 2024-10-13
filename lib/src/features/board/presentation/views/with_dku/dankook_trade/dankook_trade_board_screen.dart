import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:umate/src/core/utils/extensions.dart';

import '../../../../../../core/services/router/router_service.dart';
import '../../../../../../core/utils/date_time_formatter.dart';
import '../../../controllers/board_controller.dart';
import '../../../widgets/board_tab.dart';
import '../../../widgets/post_preview_card.dart';

class DankookTradeBoardScreen extends ConsumerStatefulWidget {
  const DankookTradeBoardScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() {
    // TODO: implement createState
    return _DankookTradeBoardScreenState();
  }
}

class _DankookTradeBoardScreenState
    extends ConsumerState<DankookTradeBoardScreen> with DateTimeFormatter {
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
    final tradeBoard = ref.watch(dankookTradeBoardControllerProvider);

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        heroTag: "write_trade",
        shape: const CircleBorder(),
        onPressed: () {
          ref.read(routerServiceProvider).pushNamed(
                AppRoute.addDankookTradePost.name,
              );
        },
        backgroundColor: context.palette.surfaceDim,
        child: Icon(
          Icons.edit,
          color: context.palette.onSecondary,
        ),
      ),
      body: BoardTab(
        board: tradeBoard,
        onRefresh: () async {
          ref.read(dankookTradeBoardControllerProvider.notifier).refresh();
        },
        onFetch: () async {
          ref.read(dankookTradeBoardControllerProvider.notifier).fetch();
        },
        postTagItems: (post) => [
          PostTagItem(
            title: post.status,
          ),
          PostTagItem(
            title: post.tradePlace,
          ),
        ],
        onTapPost: (post) {
          ref.read(routerServiceProvider).pushNamed(
            AppRoute.dankookTradePost.name,
            pathParameters: {
              'id': post.id.toString(),
            },
          );
        },
      ),
    );
  }
}
