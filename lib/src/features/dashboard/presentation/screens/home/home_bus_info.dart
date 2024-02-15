part of 'home_screen.dart';

class BusArrivalInfo {
  final BusInfo busInfo;
  final List<ArrivalInfo> arrivalInfoList;

  BusArrivalInfo({
    required this.busInfo,
    required this.arrivalInfoList,
  });
}

class BusInfo {
  final String busNo;
  final Color busColor;

  BusInfo({
    required this.busNo,
    required this.busColor,
  });
}

class ArrivalInfo {
  final String stationName;
  final int? remainingStation;
  final int? predictTime;

  ArrivalInfo({
    required this.stationName,
    required this.remainingStation,
    required this.predictTime,
  });
}

class HomeBusInfo extends ConsumerStatefulWidget{
  const HomeBusInfo({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() {
    return _HomeBusInfoState();
  }

}

class _HomeBusInfoState extends ConsumerState<HomeBusInfo> {

  late final Future<BusArrivalInfoModel> homeBusArrivalInfo;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    homeBusArrivalInfo = ref.read(busRepositoryProvider).getBusArrivalInfo();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    final List<BusInfo> busList = [
      BusInfo(
        busNo: "shuttle-bus",
        busColor: Colors.blueAccent,
      ),
      BusInfo(
        busNo: "24",
        busColor: Colors.lightGreen,
      ),
      BusInfo(
        busNo: "720-3",
        busColor: Colors.lightGreen,
      ),
      BusInfo(
        busNo: "8100",
        busColor: Colors.redAccent,
      ),
      BusInfo(
        busNo: "1101",
        busColor: Colors.redAccent,
      ),
      BusInfo(
        busNo: "102",
        busColor: Colors.redAccent,
      ),
    ];

    return OrbBoardContainer(
      titleText: "버스 정보",
      child: FutureBuilder<BusArrivalInfoModel>(
        future: homeBusArrivalInfo,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final busArrivalInfoModel = snapshot.data as BusArrivalInfoModel;

            final busArrivalInfoList = <BusArrivalInfo>[];

            for (final busInfo in busList) {
              final arrivalInfoList = <ArrivalInfo>[];

              final entranceBus = busArrivalInfoModel.entranceBusList
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

              final plazaBus = busArrivalInfoModel.plazaBusList
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
            return Column(
              children: [
                for (final busArrivalInfo in busArrivalInfoList)
                  HomeBusListTile(
                    busNo: busArrivalInfo.busInfo.busNo,
                    busColor: busArrivalInfo.busInfo.busColor,
                    arrivalInfoList: busArrivalInfo.arrivalInfoList,
                  ),
              ],
            );
          } else {
            return const OrbShimmerContent();
          }
        },
      ),
    );
  }
}

class HomeBusListTile extends StatelessWidget {
  final String busNo;
  final Color busColor;
  final List<ArrivalInfo> arrivalInfoList;

  const HomeBusListTile({
    super.key,
    required this.busNo,
    required this.busColor,
    required this.arrivalInfoList,
  });

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    final ThemeData themeData = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 4,
      ),
      child: OrbListTile(
        title: SizedBox(
          width: 64,
          child: Text(
            busNo,
            style: themeData.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.w600,
              color: busColor,
            ),
          ),
        ),
        content: ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: arrivalInfoList.length,
          itemBuilder: (context, index) {
            final busArrivalInfo = arrivalInfoList[index];
            return Padding(
              padding: const EdgeInsets.only(
                bottom: 4,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    busArrivalInfo.stationName,
                    style: themeData.textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(
                    switch (busArrivalInfo.predictTime) {
                      null => '정보 없음',
                      <= 60 => '곧 도착',
                      _ => '${(busArrivalInfo.predictTime! ~/ 60)}분',
                    },
                    style: themeData.textTheme.bodyMedium,
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
