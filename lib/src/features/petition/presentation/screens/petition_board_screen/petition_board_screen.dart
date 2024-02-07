import 'dart:async';

import 'package:auto_route/annotations.dart';
import 'package:danvery/src/modules/modules.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../utils/utils.dart';
import '../../../../features.dart';

part 'petition_board_screen_provider.dart';

part 'petition_search_bar.dart';

part 'petition_status_bar.dart';

part 'petition_preview_card.dart';

class PetitionStatusBarSliverDelegate extends SliverPersistentHeaderDelegate {
  PetitionStatusBarSliverDelegate({
    required this.minHeight,
    required this.maxHeight,
    required this.child,
  });

  final double minHeight;
  final double maxHeight;
  final Widget child;

  @override
  double get minExtent => minHeight;

  @override
  double get maxExtent => maxHeight;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return SizedBox.expand(child: child);
  }

  @override
  bool shouldRebuild(PetitionStatusBarSliverDelegate oldDelegate) {
    return maxHeight != oldDelegate.maxHeight ||
        minHeight != oldDelegate.minHeight ||
        child != oldDelegate.child;
  }
}

@RoutePage()
class PetitionBoardScreen extends ConsumerWidget {
  const PetitionBoardScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // TODO: implement build

    final TextEditingController keywordController = TextEditingController();
    final FocusNode focusNode = FocusNode();
    final screenNotifier = ref.watch(petitionBoardScreenProvider.notifier);
    final themeData = Theme.of(context);

    print("build");

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: NestedScrollView(
          floatHeaderSlivers: true,
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return <Widget>[
              SliverPersistentHeader(
                floating: true,
                delegate: PetitionStatusBarSliverDelegate(
                  minHeight: 100,
                  maxHeight: 100,
                  child: Container(
                    color: themeData.colorScheme.background,
                    child: Column(
                      children: [
                        PetitionSearchBar(
                          keywordController: keywordController,
                          focusNode: focusNode,
                        ),
                        Expanded(
                          child: Center(
                            child: PetitionStatusBar(
                              currentStatus: ref.watch(
                                  petitionBoardScreenProvider
                                      .select((value) => value.status)),
                              statusList: PetitionStatus.values,
                              onStatusChanged: (status) {
                                screenNotifier.onStatusChanged(status: status);
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ];
          },
          body: Consumer(
            builder: (context, ref, child) {
              return ref.watch(petitionBoardScreenProvider).petitionBoard.when(
                data: (data) {
                  if (data.content.isEmpty) {
                    return Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.search_off_rounded,
                            color: themeData.colorScheme.secondary,
                            size: 32,
                          ),
                          const SizedBox(height: 16),
                          Text(
                            "연관된 게시글이 존재하지 않아요",
                            style: themeData.textTheme.titleSmall?.copyWith(
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    );
                  }
                  return ListView.builder(
                    itemCount: data.content.length,
                    itemBuilder: (context, index) {
                      final petition = data.content[index];
                      return PetitionPreviewCard(
                        remainingDate: screenNotifier.petitionRemainingDate(
                          expiresAt: petition.expiresAt,
                        ),
                        title: petition.title,
                        duration: screenNotifier.petitionDuration(
                          createdAt: petition.createdAt,
                          expiresAt: petition.expiresAt,
                        ),
                        agreeCount: petition.agreeCount,
                        status: screenNotifier.getPetitionStatus(
                            status: petition.status),
                      );
                    },
                  );
                },
                loading: () {
                  return ListView.builder(
                    controller: ScrollController(),
                    itemCount: 10,
                    itemBuilder: (context, index) {
                      return const OrbShimmerContent();
                    },
                  );
                },
                error: (error, stackTrace) {
                  return ListView.builder(
                    controller: ScrollController(),
                    itemCount: 10,
                    itemBuilder: (context, index) {
                      return const OrbShimmerContent();
                    },
                  );
                },
              );
            },
          ),
        ),
      ),
    );
  }
}
