import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:umate/src/core/utils/extensions.dart';

import '../../../../core/services/router/router_service.dart';
import '../../../../core/utils/date_time_formatter.dart';

import '../view_models/study_board_view_model.dart';
import '../widgets/board_tab.dart';
import '../widgets/post_preview_card.dart';

class StudyBoardScreen extends ConsumerStatefulWidget {
  const StudyBoardScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() {
    // TODO: implement createState
    return _StudyBoardScreenState();
  }
}

class _StudyBoardScreenState extends ConsumerState<StudyBoardScreen>
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
    final studyBoard = ref.watch(studyBoardViewModelProvider);

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
        board: studyBoard,
        onFetch: () async {
          ref.read(studyBoardViewModelProvider.notifier).fetch();
        },
        onFetchMore: (currentPage) async {
          ref.read(studyBoardViewModelProvider.notifier).fetchMore(
                page: currentPage,
              );
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
        onTapPost: (post) {},
      ),
    );
  }
}