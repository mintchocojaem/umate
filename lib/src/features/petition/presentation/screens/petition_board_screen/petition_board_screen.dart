import 'dart:async';

import 'package:danvery/src/modules/modules.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../features.dart';

part 'petition_board_screen_provider.dart';

part 'petition_search_bar.dart';

part 'petition_status_bar.dart';

part 'petition_preview_card.dart';

class PetitionBoardScreen extends ConsumerWidget {
  const PetitionBoardScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // TODO: implement build

    final TextEditingController keywordController = TextEditingController();

    final screenNotifier = ref.watch(petitionBoardScreenProvider.notifier);

    print("build");

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          children: [
            PetitionSearchBar(
              keywordController: keywordController,
            ),
            const SizedBox(height: 8),
            /*
            Consumer(
              builder: (context, ref, child) {
                final petitionStatus = ref.watch(petitionStatusProvider);
                return PetitionStatusBar(
                  currentStatus: petitionStatus,
                  statusList: PetitionStatus.values,
                  onStatusChanged: (status) {
                    screenNotifier.onStatusChanged(status: status);
                  },
                );
              },
            ),
             */
            Consumer(
              builder: (context, ref, child) {
                final petitionStatus = ref.watch(petitionBoardScreenProvider
                    .select((value) => value.status));
                return PetitionStatusBar(
                  currentStatus: petitionStatus,
                  statusList: PetitionStatus.values,
                  onStatusChanged: (status) {
                    screenNotifier.onStatusChanged(status: status);
                  },
                );
              },
            ),
            const SizedBox(height: 8),
            /*
            Expanded(
              child: Consumer(
                builder: (context, ref, child) {
                  print("petition board");
                  final petitionBoard = ref.watch(petitionBoardProvider);
                  return petitionBoard.when(
                    data: (data) => ListView.builder(
                      itemCount: data.content.length,
                      itemBuilder: (context, index) {
                        final petition = data.content[index];
                        return PetitionPreviewCard(
                          remainingDate: screenNotifier
                              .petitionRemainingDate(petition.expiresAt),
                          title: petition.title,
                          duration: screenNotifier.petitionDuration(
                            petition.createdAt,
                            petition.expiresAt,
                          ),
                          agreeCount: petition.agreeCount,
                          status:
                              screenNotifier.getPetitionStatus(petition.status),
                        );
                      },
                    ),
                    loading: () => ListView.builder(
                      itemCount: 10,
                      itemBuilder: (context, index) {
                        return const OrbShimmerContent();
                      },
                    ),
                    error: (error, stackTrace) => ListView.builder(
                      itemCount: 10,
                      itemBuilder: (context, index) {
                        return const OrbShimmerContent();
                      },
                    ),
                  );
                },
              ),
            ),
             */
            Expanded(
              child: Consumer(
                builder: (context, ref, child) {
                  return FutureBuilder(
                    future:
                        ref.watch(petitionBoardScreenProvider).petitionBoard,
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return ListView.builder(
                          itemCount: 10,
                          itemBuilder: (context, index) {
                            return const OrbShimmerContent();
                          },
                        );
                      } else if(snapshot.hasData){
                        final data = snapshot.data as PetitionBoardModel;
                        return ListView.builder(
                          itemCount: data.content.length,
                          itemBuilder: (context, index) {
                            final petition = data.content[index];
                            return PetitionPreviewCard(
                              remainingDate: screenNotifier
                                  .petitionRemainingDate(petition.expiresAt),
                              title: petition.title,
                              duration: screenNotifier.petitionDuration(
                                petition.createdAt,
                                petition.expiresAt,
                              ),
                              agreeCount: petition.agreeCount,
                              status: screenNotifier
                                  .getPetitionStatus(petition.status),
                            );
                          },
                        );
                      } else {
                        return ListView.builder(
                          itemCount: 10,
                          itemBuilder: (context, index) {
                            return const OrbShimmerContent();
                          },
                        );
                      }
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
