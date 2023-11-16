import 'package:danvery/domain/board/board_provider.dart';
import 'package:danvery/modules/orb/components/components.dart';
import 'package:danvery/routes/router_provider.dart';
import 'package:danvery/screens/main/board/widgets/petition_card.dart';
import 'package:danvery/screens/main/board/widgets/petition_status_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import '../../../routes/route_path.dart';

class BoardScreen extends ConsumerStatefulWidget {
  const BoardScreen({Key? key}) : super(key: key);

  @override
  createState() => _BoardScreen();
}

class _BoardScreen extends ConsumerState with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  final ScrollController controller = ScrollController();
  final TextEditingController searchController = TextEditingController();
  final FocusNode searchFocusNode = FocusNode();

  late double initialTopBarSize; // PetitionStatusBar()의 최대 높이
  late double topContainerHeight; // 원하는 초기 높이값 설정
  late final double minTopContainerHeight; // 최소 높이값 설정
  late final double scrollSpeed;

  @override
  void initState() {
    super.initState();
    initialTopBarSize = 56;
    topContainerHeight = initialTopBarSize;
    minTopContainerHeight = 0;
    scrollSpeed = 5;
    controller.addListener(() async {
      if (controller.position.userScrollDirection == ScrollDirection.reverse) {
        if (topContainerHeight > minTopContainerHeight) {
          setState(() {
            topContainerHeight -= scrollSpeed;
            if (topContainerHeight < minTopContainerHeight) {
              topContainerHeight = minTopContainerHeight;
            }
          });
        }
      }

      if (controller.position.userScrollDirection == ScrollDirection.forward) {
        if (topContainerHeight < initialTopBarSize) {
          setState(() {
            topContainerHeight += scrollSpeed;
            if (topContainerHeight > initialTopBarSize) {
              topContainerHeight = initialTopBarSize;
            }
          });
        }
      }

      if (controller.position.pixels >= controller.position.maxScrollExtent) {
        await ref.read(boardProvider.notifier).getPetitionBoard();
      }
    });
  }

  @override
  void dispose() {
    controller.dispose();
    searchController.dispose();
    searchFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final ThemeData themeData = Theme.of(context);
    final board = ref.watch(boardProvider);
    return OrbScaffold(
      defaultAppBar: false,
      shrinkWrap: true,
      scrollBody: false,
      body: Column(
        children: [
          TextFormField(
            focusNode: searchFocusNode,
            controller: searchController,
            textInputAction: TextInputAction.search,
            decoration: InputDecoration(
              hintText: '검색',
              hintStyle: Theme.of(context).textTheme.bodyMedium,
              prefixIcon: const Icon(Icons.search),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 8,
              ),
              counterText: '',
              suffixIcon: searchController.text.isNotEmpty
                  ? searchFocusNode.hasFocus
                      ? TextButton(
                          onPressed: () {
                            setState(() {
                              searchController.clear();
                            });
                          },
                          child: Text(
                            '취소',
                            style: themeData.textTheme.bodyMedium,
                          ),
                        )
                      : IconButton(
                          onPressed: () {
                            ref
                                .read(searchKeywordProvider.notifier)
                                .update((state) => '');
                            ref
                                .read(boardProvider.notifier)
                                .getPetitionBoard(init: true)
                                .whenComplete(() {
                              searchController.clear();
                              searchFocusNode.unfocus();
                            });
                          },
                          icon: const Icon(Icons.clear),
                        )
                  : null,
            ),
            maxLines: 1,
            maxLength: 50,
            onChanged: (value) {
              setState(() {});
            },
            onFieldSubmitted: (value) {
              if (ref.read(searchKeywordProvider) == value) {
                return;
              }
              ref.read(searchKeywordProvider.notifier).update((state) => value);
              ref.read(boardProvider.notifier).getPetitionBoard(init: true);
            },
          ),
          board.hasValue
              ? Opacity(
                  opacity: topContainerHeight / initialTopBarSize,
                  child: SizedBox(
                    height: topContainerHeight <= 8 ? 8 : topContainerHeight,
                    child: PetitionStatusBar(
                      onSelected: (value) {
                        ref
                            .read(petitionStatusProvider.notifier)
                            .update((state) => value);
                      },
                    ),
                  ),
                )
              : const SizedBox(),
          Expanded(
            child: board.when(
              data: (value) {
                final petitions = value.content;
                return RefreshIndicator(
                  color: themeData.colorScheme.primary,
                  onRefresh: () async {
                    return await ref
                        .read(boardProvider.notifier)
                        .getPetitionBoard(init: true);
                  },
                  child: petitions.isEmpty
                      ? Center(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const Text("😢", style: TextStyle(fontSize: 64),),
                              const SizedBox(height: 16,),
                              Text(
                                '연관된 게시글이 존재하지 않아요',
                                style: themeData.textTheme.titleSmall,
                              ),
                            ],
                          ),
                        )
                      : ListView.builder(
                          controller: controller,
                          itemCount: petitions.length,
                          itemBuilder: (context, index) {
                            final petition = petitions[index];
                            final createdAt = DateFormat("yy.MM.dd")
                                .format(DateTime.parse(petition.createdAt));
                            final expiresAt = DateFormat("yy.MM.dd")
                                .format(DateTime.parse(petition.expiresAt));
                            final today = DateTime.now();
                            final remainingDate = today
                                    .isAfter(DateTime.parse(petition.expiresAt))
                                ? "마감"
                                : "${DateTime.parse(petition.expiresAt).difference(today).inDays}일 남음";
                            final duration = "$createdAt ~ $expiresAt";
                            final Widget petitionCard = Padding(
                              padding: const EdgeInsets.only(bottom: 8),
                              child: PetitionCard(
                                remainingDate: remainingDate,
                                title: petition.title,
                                duration: duration,
                                agreeCount: petition.agreeCount,
                                status: petition.status.name,
                                onTap: () {
                                  ref.read(routerProvider).push(
                                        RouteInfo.petition.fullPath,
                                        extra: petition.id,
                                      );
                                },
                              ),
                            );
                            if (index == petitions.length - 1 &&
                                value.hasNext) {
                              return Column(
                                children: [
                                  petitionCard,
                                  const OrbShimmerContent(),
                                ],
                              );
                            }
                            return petitionCard;
                          },
                        ),
                );
              },
              loading: () {
                return ListView.builder(
                  itemCount: 5,
                  itemBuilder: (context, index) {
                    return const Column(
                      children: [
                        OrbShimmerContent(),
                        OrbDivider(),
                      ],
                    );
                  },
                );
              },
              error: (error, stackTrace) {
                return ListView.builder(
                  itemCount: 5,
                  itemBuilder: (context, index) {
                    return const Column(
                      children: [
                        OrbShimmerContent(),
                        OrbDivider(),
                      ],
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
