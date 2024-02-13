import 'package:flutter/material.dart';

class BusArrivalInfo{
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