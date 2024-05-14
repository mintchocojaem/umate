import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../domain/models/petition_status.dart';

class PetitionBoardCategoryNotifier
    extends AutoDisposeNotifier<PetitionStatus> {

  @override
  PetitionStatus build() {
    return PetitionStatus.active;
  }

  void changeCategory(PetitionStatus status) {
    state = status;
  }
}
