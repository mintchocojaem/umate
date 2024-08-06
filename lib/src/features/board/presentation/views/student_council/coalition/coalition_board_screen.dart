import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:umate/src/core/utils/extensions.dart';

import '../../../../../../core/services/router/router_service.dart';
import '../../../../../../core/utils/date_time_formatter.dart';
import '../../../../domain/models/student_council/coalition_type.dart';

import '../../../controllers/board_controller.dart';
import '../../../controllers/student_council/coalition/coalition_category_controller.dart';
import '../../../widgets/category_bar.dart';
import '../../../widgets/board_tab.dart';

part 'coalition_category_bar.dart';

class CoalitionBoardScreen extends ConsumerStatefulWidget {
  const CoalitionBoardScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() {
    // TODO: implement createState
    return _CoalitionBoardScreenState();
  }
}

class _CoalitionBoardScreenState extends ConsumerState<CoalitionBoardScreen>
    with DateTimeFormatter {
  final ScrollController _scrollController = ScrollController();

  final List<CoalitionType> categoryList = [
    CoalitionType.food,
    CoalitionType.health,
    CoalitionType.culture,
    CoalitionType.etc,
  ];

  @override
  void dispose() {
    // TODO: implement dispose
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    final coalitionBoard = ref.watch(coalitionBoardControllerProvider);

    return NestedScrollView(
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
                child: CoalitionCategoryBar(
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
        board: coalitionBoard,
        onRefresh: () async {
          await ref.read(coalitionBoardControllerProvider.notifier).refresh();
        },
        onFetch: () async {
          await ref.read(coalitionBoardControllerProvider.notifier).fetch();
        },
        postTagItems: (post) => [],
        onTapPost: (post) {
          ref.read(routerServiceProvider).pushNamed(
            AppRoute.coalitionPost.name,
            pathParameters: {
              'id': post.id.toString(),
            },
          );
        },
      ),
    );
  }
}
