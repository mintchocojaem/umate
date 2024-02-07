part of 'petition_board_screen.dart';

final petitionBoardScreenProvider = NotifierProvider.autoDispose<
    PetitionBoardScreenNotifier, PetitionBoardScreenState>(
  () => PetitionBoardScreenNotifier(),
);

class PetitionBoardScreenState {
  PetitionStatus status;
  AsyncValue<PetitionBoardModel> petitionBoard;

  PetitionBoardScreenState({
    required this.status,
    required this.petitionBoard,
  });

  copyWith({
    PetitionStatus? status,
    AsyncValue<PetitionBoardModel>? petitionBoard,
  }) {
    return PetitionBoardScreenState(
      status: status ?? this.status,
      petitionBoard: petitionBoard ?? this.petitionBoard,
    );
  }
}

class PetitionBoardScreenNotifier
    extends AutoDisposeNotifier<PetitionBoardScreenState>
    with PetitionDateFormat {
  @override
  PetitionBoardScreenState build() {
    // TODO: implement build
    /*
    ref.keepAlive();
    ref.listen(petitionStatusProvider, (previous, next) {
      ref.read(petitionBoardProvider.notifier).getPetitionBoard(
            status: next,
          );
    });

     */
    Future(() async {
      await getPetitionBoard(status: PetitionStatus.active);
    });
    return PetitionBoardScreenState(
      status: PetitionStatus.active,
      petitionBoard: const AsyncValue.loading(),
    );
  }

  Future<void> getPetitionBoard({
    required PetitionStatus status,
  }) async {
    state = state.copyWith(
      status: status,
      petitionBoard: const AsyncValue.loading(),
    );
    final petitionBoard = await AsyncValue.guard(
        () => ref.read(petitionRepositoryProvider).getPetitionBoard(
              status: status.value,
              page: 0,
              size: 10,
            ));
    state = state.copyWith(petitionBoard: petitionBoard);
  }

  Future<void> onStatusChanged({required PetitionStatus status}) async {
    if (status != state.status) {
      ref.read(dioClientProvider).cancelAllRequests();
      await getPetitionBoard(status: status);
    }
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
    final createdDate = dateFormatCompact(createdAt);
    final expiresDate = dateFormatCompact(expiresAt);
    return '$createdDate ~ $expiresDate';
  }

  String getPetitionStatus({required String status}) {
    return PetitionStatus.values
        .firstWhere((element) => element.value == status)
        .display;
  }

}
