import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../domain/models/student_council/petition_status.dart';
import '../../board_controller.dart';

final petitionCategoryControllerProvider =
    NotifierProvider.autoDispose<CoalitionCategoryController, PetitionStatus>(
  () => CoalitionCategoryController(),
);

class CoalitionCategoryController extends AutoDisposeNotifier<PetitionStatus> {
  @override
  PetitionStatus build() {
    // TODO: implement build
    return PetitionStatus.active;
  }

  void change({
    required PetitionStatus type,
  }) {
    state = type;
    ref.read(petitionBoardControllerProvider.notifier).refresh();
  }
}
