import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:umate/src/core/utils/extensions.dart';

import '../../../../../../core/services/router/router_service.dart';
import '../../../../../../core/utils/date_time_formatter.dart';
import '../../../controllers/board_controller.dart';
import '../../../widgets/board_tab.dart';
import '../../../widgets/post_preview_card.dart';

class DantudyBoardScreen extends ConsumerStatefulWidget {
  const DantudyBoardScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() {
    // TODO: implement createState
    return _DantudyBoardScreenState();
  }
}

class _DantudyBoardScreenState extends ConsumerState<DantudyBoardScreen>
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
    final studyBoard = ref.watch(dantudyBoardControllerProvider);

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        heroTag: "write_study",
        shape: const CircleBorder(),
        onPressed: () {
          ref.read(routerServiceProvider).pushNamed(
                AppRoute.addDantudyPost.name,
              );
        },
        backgroundColor: context.palette.surfaceDim,
        child: Icon(
          Icons.edit,
          color: context.palette.onSecondary,
        ),
      ),
      body: BoardTab(
        board: studyBoard,
        onRefresh: () async {
          ref.read(dantudyBoardControllerProvider.notifier).refresh();
        },
        onFetch: () async {
          ref.read(dantudyBoardControllerProvider.notifier).fetch();
        },
        postTagItems: (post) => [
          PostTagItem(
            title: "${post.recruitedCount}명 모집",
          ),
          if (post.tag != null)
            PostTagItem(
              title: "${post.tag}",
            ),
        ],
        onTapPost: (post) {
          ref.read(routerServiceProvider).pushNamed(
            AppRoute.dantudyPost.name,
            pathParameters: {
              'id': post.id.toString(),
            },
          );
        },
      ),
    );
  }
}
