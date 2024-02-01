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

    PetitionStatus currentPetitionStatus = PetitionStatus.active;

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
            PetitionStatusBar(
              statusList: const [
                PetitionStatus.active,
                PetitionStatus.waiting,
                PetitionStatus.answered,
                PetitionStatus.expired,
              ],
              onStatusChanged: (status) {
                //ref.read(petitionBoardProvider.notifier).getPetitionBoard();
                currentPetitionStatus = status;
              },
            ),
            const SizedBox(height: 8),
            Expanded(
              child: Consumer(builder: (context, ref, child) {
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
              }),
            ),
          ],
        ),
      ),
    );
  }
}
