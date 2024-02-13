import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../features.dart';

mixin class PetitionBoardScreenController {
  Future<PetitionBoardModel> getPetitionBoard(
    WidgetRef ref, {
    required PetitionStatus status,
  }) async {
    final result = await ref.read(petitionRepositoryProvider).getPetitionBoard(
          status: status.value,
          page: 0,
          size: 10,
        );
    return result;
  }

  String petitionRemainingDate({required String expiresAt}) {
    final date = DateTime.parse(expiresAt);
    final now = DateTime.now();
    return now.isBefore(date) ? 'D-${date.difference(now).inDays}' : '마감';
  }

  String petitionDuration({
    required String createdAt,
    required String expiresAt,
  }) {
    final createdDate = PetitionDateFormat.dateFormatCompact(createdAt);
    final expiresDate = PetitionDateFormat.dateFormatCompact(expiresAt);
    return '$createdDate ~ $expiresDate';
  }

  String getPetitionStatus({required String status}) {
    return PetitionStatus.values
        .firstWhere((element) => element.value == status)
        .display;
  }
}
