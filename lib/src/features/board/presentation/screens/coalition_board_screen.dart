import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:umate/src/core/utils/extensions.dart';

import '../../../../core/utils/date_time_formatter.dart';
import '../../domain/models/coalition_type.dart';
import '../view_models/coalition_board_view_model.dart';

import '../widgets/category_bar.dart';
import '../widgets/board_tab.dart';

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
  late final ScrollController _scrollController;

  final List<CoalitionType> categoryList = [
    CoalitionType.food,
    CoalitionType.health,
    CoalitionType.culture,
    CoalitionType.etc,
  ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _scrollController = ScrollController();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    final coalitionBoard = ref.watch(coalitionBoardViewModelProvider);

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
                child: CategoryBar(
                  currentIndex: categoryList.indexOf(
                    ref.watch(coalitionTypeProvider),
                  ),
                  categoryList: [
                    for (final category in categoryList) category.displayName,
                  ],
                  onIndexChanged: (index) {
                    ref
                        .read(coalitionTypeProvider.notifier)
                        .update((state) => categoryList[index]);
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
        onFetch: () async {
          await ref.read(coalitionBoardViewModelProvider.notifier).fetch();
        },
        onFetchMore: (currentPage) async {
          await ref.read(coalitionBoardViewModelProvider.notifier).fetchMore(
                page: currentPage,
              );
        },
        postTagItems: (post) => [],
        onTapPost: (int index) {},
      ),
    );
  }
}
