part of 'home_screen.dart';

final homeScreenProvider =
    NotifierProvider.autoDispose<HomeScreenNotifier, HomeScreenState>(
  () => HomeScreenNotifier(),
);

class HomeScreenState {
  AsyncValue<PetitionBoardModel> petitionBoard;
  AsyncValue<BusArrivalInfoModel> busArrivalInfo;

  HomeScreenState({
    required this.petitionBoard,
    required this.busArrivalInfo,
  });

  HomeScreenState copyWith({
    AsyncValue<PetitionBoardModel>? petitionBoard,
    AsyncValue<BusArrivalInfoModel>? busArrivalInfo,
  }) {
    return HomeScreenState(
      petitionBoard: petitionBoard ?? this.petitionBoard,
      busArrivalInfo: busArrivalInfo ?? this.busArrivalInfo,
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
      await getHomeBusArrivalInfo();
    });
    return HomeScreenState(
      petitionBoard: const AsyncValue.loading(),
      busArrivalInfo: const AsyncValue.loading(),
    );
  }

  Future<void> getHomeBusArrivalInfo() async {
    state = state.copyWith(
      busArrivalInfo: const AsyncValue.loading(),
    );

    final result = await AsyncValue.guard(
      () async {
        return await ref.read(dashboardProvider).getHomeBusArrivalInfo();
      },
    );

    state = state.copyWith(
      busArrivalInfo: result,
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

  String petitionCreatedAt({required String createdAt}) {
    return dateFormatRelative(createdAt);
  }

  BusInfo getBusInfo({
    required String busNo,
    required Color busColor,
  }) {
    final busArrivalInfo = state.busArrivalInfo.requireValue;
    final entranceBusList = busArrivalInfo.entranceBusList;
    final plazaBusList = busArrivalInfo.plazaBusList;

    final busArrivalInfoList = <BusArrivalInfo>[];

    final BusModel? entranceBus = entranceBusList.where(
      (element) => element.busNo == busNo,
    ).firstOrNull;

    if (entranceBus != null) {
      busArrivalInfoList.add(
        BusArrivalInfo(
          stationName: "정문",
          remainingStation: entranceBus.remainingStation,
          predictTime: entranceBus.predictTime,
        ),
      );
    }

    final BusModel? plazaBus = plazaBusList.where(
      (element) => element.busNo == busNo,
    ).firstOrNull;

    if (plazaBus != null) {
      busArrivalInfoList.add(
        BusArrivalInfo(
          stationName: "곰상",
          remainingStation: plazaBus.remainingStation,
          predictTime: plazaBus.predictTime,
        ),
      );
    }

    return BusInfo(
      busNo: busNo,
      busColor: busColor,
      busArrivalInfoList: busArrivalInfoList,
    );
  }
}
