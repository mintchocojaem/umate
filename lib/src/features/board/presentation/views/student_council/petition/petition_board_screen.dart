import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:umate/src/core/utils/extensions.dart';

import '../../../../../../core/services/router/router_service.dart';
import '../../../../../../core/utils/date_time_formatter.dart';
import '../../../../domain/models/student_council/petition_status.dart';
import '../../../controllers/board_controller.dart';
import '../../../controllers/student_council/petition/petition_category_controller.dart';
import '../../../widgets/board_tab.dart';
import '../../../widgets/category_bar.dart';
import '../../../widgets/post_preview_card.dart';

part 'petition_category_bar.dart';

class PetitionBoardScreen extends ConsumerStatefulWidget {
  const PetitionBoardScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() {
    // TODO: implement createState
    return _PetitionBoardScreenState();
  }
}

class _PetitionBoardScreenState extends ConsumerState<PetitionBoardScreen>
    with DateTimeFormatter {
  final List<PetitionStatus> categoryList = [
    PetitionStatus.active,
    PetitionStatus.waiting,
    PetitionStatus.answered,
    PetitionStatus.expired,
  ];

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
    final petitionBoard = ref.watch(petitionBoardControllerProvider);

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        heroTag: "write_petition",
        shape: const CircleBorder(),
        onPressed: () {
          ref.read(routerServiceProvider).pushNamed(
                AppRoute.addPetitionPost.name,
              );
        },
        backgroundColor: context.palette.surfaceDim,
        child: Icon(
          Icons.edit,
          color: context.palette.onSecondary,
        ),
      ),
      body: NestedScrollView(
        controller: _scrollController,
        floatHeaderSlivers: true,
        headerSliverBuilder: (context, innerBoxIsScrolled) {
          return [
            SliverAppBar(
              automaticallyImplyLeading: false,
              floating: true,
              snap: true,
              backgroundColor: Colors.transparent,
              surfaceTintColor: Colors.transparent,
              flexibleSpace: Container(
                decoration: BoxDecoration(
                  color: context.palette.background,
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(20),
                    bottomRight: Radius.circular(20),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      offset: const Offset(0, 2),
                      blurRadius: 4,
                    ),
                  ],
                ),
                child: Center(
                  child: PetitionCategoryBar(
                    categoryList: categoryList,
                    onIndexChanged: (index) {
                      _scrollController.jumpTo(0);
                    },
                  ),
                ),
              ),
            ),
          ];
        },
        body: BoardTab(
          board: petitionBoard,
          onRefresh: () async {
            await ref.read(petitionBoardControllerProvider.notifier).refresh();
          },
          onFetch: () async {
            await ref.read(petitionBoardControllerProvider.notifier).fetch();
          },
          postTagItems: (post) => [
            PostTagItem(
              title: post.status.korean,
            ),
            PostTagItem(
              title: dateFormatToRemaining(
                post.expiresAt,
              ),
            ),
            PostTagItem(
              title: "참여 ${post.agreeCount}명",
            ),
          ],
          onTapPost: (post) {
            ref.read(routerServiceProvider).pushNamed(
              AppRoute.petitionPost.name,
              pathParameters: {
                'id': post.id.toString(),
              },
            );
          },
        ),
      ),
    );
  }
}
