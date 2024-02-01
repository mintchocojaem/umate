import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../features.dart';

final petitionBoardProvider = AsyncNotifierProvider.autoDispose<
    PetitionBoardNotifier, PetitionBoardModel>(
  () => PetitionBoardNotifier(),
);

class PetitionBoardNotifier
    extends AutoDisposeAsyncNotifier<PetitionBoardModel> {
  late final PetitionRepository _petitionBoardRepository;
  late final KeepAliveLink _link;

  @override
  FutureOr<PetitionBoardModel> build() async{
    _petitionBoardRepository = ref.watch(petitionRepositoryProvider);
    getPetitionBoard();
    return future;
  }

  Future<void> getPetitionBoard() async {
    _link = ref.keepAlive();

    state = const AsyncValue.loading();
    state = await AsyncValue.guard(
      () async => await _petitionBoardRepository.getPetitionBoard(
        page: 0,
        size: 10,
      ),
    );

    if (state.hasError) {
      _link.close();
    }
  }
}
