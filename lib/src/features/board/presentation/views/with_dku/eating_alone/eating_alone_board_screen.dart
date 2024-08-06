import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:umate/src/core/utils/extensions.dart';

import '../../../../../../core/utils/date_time_formatter.dart';

import '../../../controllers/board_controller.dart';
import '../../../widgets/board_tab.dart';
import '../../../widgets/post_preview_card.dart';

class EatingAloneBoardScreen extends ConsumerStatefulWidget {
  const EatingAloneBoardScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() {
    // TODO: implement createState
    return _EatingAloneBoardScreenState();
  }
}

class _EatingAloneBoardScreenState extends ConsumerState<EatingAloneBoardScreen>
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
    final eatingAloneBoard = ref.watch(eatingAloneBoardControllerProvider);

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
        board: eatingAloneBoard,
        onRefresh: () async {
          await ref.read(eatingAloneBoardControllerProvider.notifier).refresh();
        },
        onFetch: () async {
          await ref.read(eatingAloneBoardControllerProvider.notifier).fetch();
        },
        postTagItems: (post) => [
          PostTagItem(
            title: "${post.recruitedCount}명 모집",
          ),
        ],
        onTapPost: (post) {},
      ),
    );
  }
}
