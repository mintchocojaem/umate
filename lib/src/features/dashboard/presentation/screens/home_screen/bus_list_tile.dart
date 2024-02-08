part of 'home_screen.dart';

class BusArrivalInfo {
  final String stationName;
  final int? remainingStation;
  final int? predictTime;

  const BusArrivalInfo({
    required this.stationName,
    required this.remainingStation,
    this.predictTime,
  });
}

class BusInfo {
  final String busNo;
  final Color busColor;
  final List<BusArrivalInfo> busArrivalInfoList;

  const BusInfo({
    required this.busNo,
    required this.busColor,
    required this.busArrivalInfoList,
  });
}

class BusListTile extends StatelessWidget {
  final BusInfo busInfo;

  const BusListTile({
    super.key,
    required this.busInfo,
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
            busInfo.busNo == "shuttle-bus" ? "셔틀" : busInfo.busNo,
            style: themeData.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.w600,
              color: busInfo.busColor,
            ),
          ),
        ),
        content: Column(
          children: [
            for (final busArrivalInfo in busInfo.busArrivalInfoList)
              Padding(
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
              ),
          ],
        ),
      ),
    );
  }
}
