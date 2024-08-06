import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../domain/models/student_council/coalition_type.dart';
import '../../board_controller.dart';

final coalitionCategoryControllerProvider =
    NotifierProvider.autoDispose<CoalitionCategoryController, CoalitionType>(
  () => CoalitionCategoryController(),
);

class CoalitionCategoryController extends AutoDisposeNotifier<CoalitionType> {
  @override
  CoalitionType build() {
    // TODO: implement build
    return CoalitionType.food;
  }

  void change({
    required CoalitionType type,
  }) {
    state = type;
    ref.read(coalitionBoardControllerProvider.notifier).refresh();
  }
}
