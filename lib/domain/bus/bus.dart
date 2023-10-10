import 'package:freezed_annotation/freezed_annotation.dart';

part 'bus.freezed.dart';
part 'bus.g.dart';

@freezed
class BusList with _$BusList{
  const factory BusList({
    required String capturedAt,
    required List<Bus> busArrivalList,
  }) = _BusList;

  factory BusList.fromJson(Map<String, dynamic> json) => _$BusListFromJson(json);
}

@freezed
class BusInfo with _$BusInfo {
  const factory BusInfo({
    required BusList junmoonBus,
    required BusList gomsangBus,
  }) = _BusInfo;

  factory BusInfo.fromJson(Map<String, dynamic> json) => _$BusInfoFromJson(json);
}

@freezed
class Bus with _$Bus {
  const factory Bus({
    @Default(0) int locationNo1,
    @Default(0) int predictTime1,
    required String busNo,
  }) = _Bus;

  factory Bus.fromJson(Map<String, dynamic> json) => _$BusFromJson(json);
}
