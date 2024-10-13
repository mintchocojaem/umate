import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:umate/src/core/utils/extensions.dart';

import '../../../../../../core/services/router/router_service.dart';
import '../../../../../../core/utils/date_time_formatter.dart';
import '../../../controllers/board_controller.dart';
import '../../../widgets/board_tab.dart';
import '../../../widgets/post_preview_card.dart';

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
    final bearEatsBoard = ref.watch(bearEatsBoardControllerProvider);

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        heroTag: "write_bear_eats",
        shape: const CircleBorder(),
        onPressed: () {
          ref.read(routerServiceProvider).pushNamed(
                AppRoute.addBearEatsPost.name,
              );
        },
        backgroundColor: context.palette.surfaceDim,
        child: Icon(
          Icons.edit,
          color: context.palette.onSecondary,
        ),
      ),
      body: BoardTab(
        board: bearEatsBoard,
        onRefresh: () async {
          await ref.read(bearEatsBoardControllerProvider.notifier).refresh();
        },
        onFetch: () async {
          await ref.read(bearEatsBoardControllerProvider.notifier).fetch();
        },
        postTagItems: (post) => [
          PostTagItem(
            title: '${post.recruitedCount}명 모집',
          ),
          PostTagItem(
            title: post.restaurant,
          ),
          PostTagItem(
            title: post.deliveryPlace,
          ),
        ],
        onTapPost: (post) {
          ref.read(routerServiceProvider).pushNamed(
            AppRoute.bearEatsPost.name,
            pathParameters: {
              'id': post.id.toString(),
            },
          );
        },
      ),
    );
  }
}
