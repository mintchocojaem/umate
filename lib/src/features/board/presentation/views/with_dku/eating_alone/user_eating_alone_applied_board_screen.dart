import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:umate/src/core/services/router/router_service.dart';

import '../../../../../../core/utils/date_time_formatter.dart';
import '../../../controllers/board_controller.dart';
import '../../../widgets/board_tab.dart';
import '../../../widgets/post_preview_card.dart';

class UserEatingAloneAppliedBoardScreen extends ConsumerStatefulWidget {
  const UserEatingAloneAppliedBoardScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() {
    // TODO: implement createState
    return _UserEatingAloneAppliedBoardScreenState();
  }
}

class _UserEatingAloneAppliedBoardScreenState
    extends ConsumerState<UserEatingAloneAppliedBoardScreen>
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
    final eatingAloneBoard =
        ref.watch(userEatingAloneAppliedBoardControllerProvider);

    return Scaffold(
      body: BoardTab(
        board: eatingAloneBoard,
        onRefresh: () async {
          await ref
              .read(userEatingAloneAppliedBoardControllerProvider.notifier)
              .refresh();
        },
        onFetch: () async {
          await ref
              .read(userEatingAloneAppliedBoardControllerProvider.notifier)
              .fetch();
        },
        postTagItems: (post) => [
          PostTagItem(
            title: "${post.recruitedCount}명 모집",
          ),
        ],
        onTapPost: (post) {
          ref.read(routerServiceProvider).pushNamed(
            AppRoute.eatingAlonePost.name,
            pathParameters: {
              'id': post.id.toString(),
            },
          );
        },
      ),
    );
  }
}
