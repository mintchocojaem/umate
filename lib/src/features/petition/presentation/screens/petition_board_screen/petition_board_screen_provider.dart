part of 'petition_board_screen.dart';

final petitionBoardScreenProvider = NotifierProvider.autoDispose<
    PetitionBoardScreenNotifier, PetitionBoardScreenState>(
  () => PetitionBoardScreenNotifier(),
);

class PetitionBoardScreenState {
  PetitionStatus status;
  Future<PetitionBoardModel> petitionBoard;

  PetitionBoardScreenState({
    required this.status,
    required this.petitionBoard,
  });

  copyWith({
    PetitionStatus? status,
    Future<PetitionBoardModel>? petitionBoard,
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
    return PetitionBoardScreenState(
      status: PetitionStatus.active,
      petitionBoard: _getPetitionBoard(status: PetitionStatus.active),
    );
  }

  Future<PetitionBoardModel> _getPetitionBoard({
    required PetitionStatus status,
  }) async {
    final petitionBoardRepository = ref.watch(petitionRepositoryProvider);
    final petitionBoard = await petitionBoardRepository.getPetitionBoard(
      page: 0,
      size: 10,
      status: status.value,
    );
    return petitionBoard;
  }

  void onStatusChanged({required PetitionStatus status}) {
    //ref.read(petitionStatusProvider.notifier).update((state) => status);
    state = state.copyWith(
      status: status,
      petitionBoard: _getPetitionBoard(status: status),
    );
  }

  String petitionRemainingDate(String expiresAt) {
    final date = DateTime.parse(expiresAt);
    final now = DateTime.now();
    return now.isBefore(date) ? 'D-${date.difference(now).inDays}' : '마감';
  }

  String petitionDuration(String createdAt, String expiresAt) {
    final createdDate = dateFormatCompact(createdAt);
    final expiresDate = dateFormatCompact(expiresAt);
    return '$createdDate ~ $expiresDate';
  }

  String getPetitionStatus(String status) {
    return PetitionStatus.values
        .firstWhere((element) => element.value == status)
        .display;
  }
}
