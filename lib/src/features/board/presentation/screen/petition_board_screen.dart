import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/services/router/router_service.dart';
import '../../../../core/utils/date_time_formatter.dart';
import '../../../../design_system/orb/orb.dart';
import '../../domain/model/petition_status.dart';
import '../../domain/use_case/get_petition_board.dart';
import '../provider/petition_board_provider.dart';
import '../provider/petition_status_provider.dart';
import '../widget/category_bar.dart';
import '../widget/petition_board_body.dart';

ScrollController? _scrollController;

Future<void> scrollUpPetitionBoard() async {
  if (_scrollController != null && _scrollController!.hasClients) {
    await _scrollController!.animateTo(
      0,
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeInOut,
    );
  }
}

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

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _scrollController = ScrollController();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _scrollController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    ref.listen(
      petitionBoardProvider,
      (prev, next) {},
    );

    final petitionBoard = ref.watch(petitionBoardProvider);

    final theme = OrbThemeData.of(context);
    final palette = theme.palette;
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        shape: const CircleBorder(),
        onPressed: () async {
          ref.read(routerServiceProvider).pushNamed(
                AppRoute.petitionWrite.name,
              );
        },
        backgroundColor: palette.surfaceDim,
        child: Icon(
          Icons.edit,
          color: palette.onSecondary,
        ),
      ),
      body: Container(
        color: palette.surfaceBright,
        child: NestedScrollView(
          controller: _scrollController,
          floatHeaderSlivers: true,
          headerSliverBuilder: (context, innerBoxIsScrolled) {
            return [
              SliverAppBar(
                automaticallyImplyLeading: false,
                floating: true,
                snap: true,
                elevation: 0,
                backgroundColor: Colors.transparent,
                surfaceTintColor: Colors.transparent,
                expandedHeight: 64,
                flexibleSpace: Container(
                  decoration: BoxDecoration(
                    color: palette.background,
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
                        ref.watch(petitionStatusProvider),
                      ),
                      categoryList: [
                        for (final category in categoryList) category.korean,
                      ],
                      onIndexChanged: (index) {
                        ref.read(petitionStatusProvider.notifier).changeStatus(
                              categoryList[index],
                            );
                        _scrollController?.jumpTo(0);
                      },
                    ),
                  ),
                ),
              ),
            ];
          },
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: petitionBoard.when(
              data: (petitionBoard) => petitionBoard.content.isEmpty
                  ? Center(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const OrbText(
                            "연관된 게시글이 존재하지 않아요",
                            type: OrbTextType.bodyLarge,
                          ),
                          const SizedBox(height: 8),
                          OrbFilledButton(
                            text: "다시 불러오기",
                            buttonSize: OrbButtonSize.compact,
                            buttonRadius: OrbButtonRadius.small,
                            buttonTextType: OrbButtonTextType.small,
                            buttonType: OrbButtonType.secondary,
                            onPressed: () async {
                              ref.read(getPetitionBoardProvider)(
                                GetPetitionBoardParams(
                                    status: categoryList.first),
                              );
                            },
                          ),
                        ],
                      ),
                    )
                  : PetitionBoardBody(
                      petitionBoard: petitionBoard,
                    ),
              error: (error, _) => Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const OrbText(
                      "게시글을 불러오는 중 오류가 발생했어요",
                      type: OrbTextType.bodyLarge,
                    ),
                    const SizedBox(height: 8),
                    OrbFilledButton(
                      text: "다시 불러오기",
                      buttonSize: OrbButtonSize.compact,
                      buttonRadius: OrbButtonRadius.small,
                      buttonTextType: OrbButtonTextType.small,
                      buttonType: OrbButtonType.secondary,
                      onPressed: () async {
                        ref.read(getPetitionBoardProvider)(
                          GetPetitionBoardParams(status: categoryList.first),
                        );
                      },
                    ),
                  ],
                ),
              ),
              loading: () => ListView.builder(
                shrinkWrap: true,
                itemCount: 5,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  return const OrbShimmerContent();
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}
