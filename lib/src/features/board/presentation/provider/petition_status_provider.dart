import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/model/petition_status.dart';
import 'petition_board_provider.dart';

final petitionStatusProvider =
    NotifierProvider.autoDispose<PetitionStatusNotifier, PetitionStatus>(
  () => PetitionStatusNotifier(),
);

class PetitionStatusNotifier extends AutoDisposeNotifier<PetitionStatus> {
  @override
  PetitionStatus build() {
    // TODO: implement build
    return PetitionStatus.active;
  }

  void changeStatus(PetitionStatus status) {
    state = status;
    ref.invalidate(petitionBoardProvider);
  }
}
