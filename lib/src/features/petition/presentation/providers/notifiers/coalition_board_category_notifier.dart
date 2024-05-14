import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../domain/models/coalition_type.dart';

class CoalitionBoardCategoryNotifier
    extends AutoDisposeNotifier<CoalitionType> {

  @override
  CoalitionType build() {
    return CoalitionType.food;
  }

  void changeCategory(CoalitionType coalitionType) {
    state = coalitionType;
  }
}
