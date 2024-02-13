import 'package:flutter/material.dart';

import '../../../../../common_widgets/common_widgets.dart';
import '../../../../../modules/modules.dart';
import '../../../../features.dart';

class HomeBusInfo extends StatelessWidget {
  final Future<List<BusArrivalInfo>> homeBusArrivalInfo;

  const HomeBusInfo({
    super.key,
    required this.homeBusArrivalInfo,
  });

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return OrbBoardContainer(
      titleText: "버스 정보",
      child: FutureWidget(
        future: homeBusArrivalInfo,
        isLoading: const OrbShimmerContent(),
        hasData: (snapshot) {
          final busArrivalInfoList = snapshot.data as List<BusArrivalInfo>;
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
        },
        hasError: (error, stackTrace) {
          return const OrbShimmerContent();
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
