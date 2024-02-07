part of 'home_screen.dart';

final homeScreenProvider =
    NotifierProvider.autoDispose<HomeScreenNotifier, HomeScreenState>(
  () => HomeScreenNotifier(),
);

class HomeScreenState {
  AsyncValue<PetitionBoardModel> petitionBoard;

  HomeScreenState({
    required this.petitionBoard,
  });

  HomeScreenState copyWith({
    AsyncValue<PetitionBoardModel>? petitionBoard,
  }) {
    return HomeScreenState(
      petitionBoard: petitionBoard ?? this.petitionBoard,
    );
  }
}

class HomeScreenNotifier extends AutoDisposeNotifier<HomeScreenState>
    with PetitionDateFormat {
  @override
  HomeScreenState build() {
    // TODO: implement build

    Future(() async {
      await getHomePetitionBoard();
    });
    return HomeScreenState(
      petitionBoard: const AsyncValue.loading(),
    );
  }

  Future<void> getHomePetitionBoard() async {
    state = state.copyWith(
      petitionBoard: const AsyncValue.loading(),
    );

    final result = await AsyncValue.guard(
      () async {
        return await ref.read(dashboardProvider).getHomePetitionBoard();
      },
    );

    state = state.copyWith(
      petitionBoard: result,
    );
  }

  String petitionCreatedAt(String createdAt) {
    return dateFormatRelative(createdAt);
  }

}
