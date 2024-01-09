import 'package:danvery/domain/board/board_provider.dart';
import 'package:danvery/modules/orb/components/components.dart';
import 'package:danvery/routes/router_provider.dart';
import 'package:danvery/screens/main/board/widgets/petition_card.dart';
import 'package:danvery/screens/main/board/widgets/petition_status_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import '../../../domain/board/post/petition_status.dart';
import '../../../routes/route_path.dart';

class BoardScreen extends ConsumerStatefulWidget {
  const BoardScreen({super.key});

  @override
  createState() => _BoardScreen();
}

class _BoardScreen extends ConsumerState with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;
  final foldableScrollController = FoldableScrollController(
    scrollController: ScrollController(),
    height: 56,
    maxHeight: 56,
    minHeight: 8,
  );
  final TextEditingController searchController = TextEditingController();
  final FocusNode searchFocusNode = FocusNode();

  @override
  void dispose() {
    foldableScrollController.dispose();
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
      orbAppBar: null,
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
              prefixIcon:
                  Icon(Icons.search, color: themeData.colorScheme.onSurface),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 8,
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
                borderSide: BorderSide(
                  color: themeData.colorScheme.surfaceVariant,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
                borderSide: BorderSide(
                  color: themeData.colorScheme.surfaceVariant,
                ),
              ),
              counterText: '',
              suffixIcon: ref.watch(searchKeywordProvider).isEmpty &&
                      searchController.text.isNotEmpty
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
                  : ref.watch(searchKeywordProvider).isNotEmpty
                      ? IconButton(
                          onPressed: () {
                            ref
                                .read(boardProvider.notifier)
                                .getPetitionBoard(refresh: true)
                                .then((value) {
                              if (value) {
                                searchController.clear();
                                searchFocusNode.unfocus();
                                foldableScrollController.initScrollPosition();
                              }
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
            onFieldSubmitted: (value) async {
              if (ref.read(searchKeywordProvider) == value) {
                return;
              }
              ref.read(searchKeywordProvider.notifier).update((state) => value);
              await ref
                  .read(boardProvider.notifier)
                  .getPetitionBoard(firstPage: true)
                  .then((value) {
                if (value) {
                  searchFocusNode.unfocus();
                  foldableScrollController.initScrollPosition();
                }
              });
            },
          ),
          OrbFoldableContainer(
            scrollController: foldableScrollController,
            child: PetitionStatusBar(
              currentStatus: ref.watch(petitionStatusProvider),
              onSelected: (value) {
                if(value == ref.read(petitionStatusProvider)){
                  return;
                }
                ref
                    .read(petitionStatusProvider.notifier)
                    .update((state) => value);
                ref.read(boardProvider.notifier).getPetitionBoard(
                      firstPage: true,
                    );
              },
            ),
            onScroll: (position) async {
              if (position.pixels >= position.maxScrollExtent - 100 &&
                  position.pixels <= position.maxScrollExtent) {
                await ref.read(boardProvider.notifier).getPetitionBoard();
              }
            },
          ),
          Expanded(
            child: board.when(
              data: (value) {
                final petitions = value.content;
                return RefreshIndicator(
                  color: themeData.colorScheme.primary,
                  onRefresh: () async {
                    await ref
                        .read(boardProvider.notifier)
                        .getPetitionBoard(firstPage: true);
                  },
                  child: petitions.isEmpty
                      ? Center(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                Icons.search_off_rounded,
                                size: 48,
                                color: themeData.colorScheme.secondary,
                              ),
                              const SizedBox(
                                height: 16,
                              ),
                              Text(
                                '연관된 게시글이 존재하지 않아요',
                                style: themeData.textTheme.titleSmall,
                              ),
                            ],
                          ),
                        )
                      : ListView.builder(
                          controller: foldableScrollController.scrollController,
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
                                        RouteInfo.petitionDetail.fullPath,
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
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          ref
              .read(routerProvider)
              .push(RouteInfo.petitionWrite.fullPath)
              .then((value) {
            final bool? isRefresh = value as bool?;
            if (isRefresh == true) {
              foldableScrollController.initScrollPosition();
            }
          });
        },
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        backgroundColor: themeData.colorScheme.secondary,
        child: Icon(
          Icons.edit_rounded,
          color: themeData.colorScheme.onSecondary,
        ),
      ),
    );
  }
}
