import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../features.dart';

mixin class HomeScreenController {
  Future<PetitionBoardModel> getHomePetitionBoard(
    WidgetRef ref, {
    required PetitionStatus status,
    required int page,
    required int size,
  }) {
    return ref.read(petitionRepositoryProvider).getPetitionBoard(
          status: status.value,
          page: page,
          size: size,
        );
  }

  Future<List<BusArrivalInfo>> getHomeBusArrivalInfo(
    WidgetRef ref, {
    required List<BusInfo> busInfoList,
  }) async {
    final busArrivalInfoModel =
        await ref.read(busRepositoryProvider).getBusArrivalInfo();

    final busArrivalInfoList = <BusArrivalInfo>[];

    for (final busInfo in busInfoList) {
      final arrivalInfoList = <ArrivalInfo>[];

      final BusModel? entranceBus = busArrivalInfoModel.entranceBusList
          .where((element) => element.busNo == busInfo.busNo)
          .firstOrNull;
      if (entranceBus != null) {
        ArrivalInfo arrivalInfo = ArrivalInfo(
          stationName: "정문",
          remainingStation: entranceBus.remainingStation,
          predictTime: entranceBus.predictTime,
        );
        arrivalInfoList.add(arrivalInfo);
      }

      final BusModel? plazaBus = busArrivalInfoModel.plazaBusList
          .where((element) => element.busNo == busInfo.busNo)
          .firstOrNull;
      if (plazaBus != null) {
        ArrivalInfo arrivalInfo = ArrivalInfo(
          stationName: "곰상",
          remainingStation: plazaBus.remainingStation,
          predictTime: plazaBus.predictTime,
        );
        arrivalInfoList.add(arrivalInfo);
      }

      BusInfo finalBusInfo = busInfo;

      if (busInfo.busNo == "shuttle-bus") {
        finalBusInfo = BusInfo(
          busNo: "셔틀",
          busColor: busInfo.busColor,
        );
      } else {
        finalBusInfo = busInfo;
      }

      busArrivalInfoList.add(
        BusArrivalInfo(
          busInfo: finalBusInfo,
          arrivalInfoList: arrivalInfoList,
        ),
      );
    }

    return busArrivalInfoList;
  }
}
