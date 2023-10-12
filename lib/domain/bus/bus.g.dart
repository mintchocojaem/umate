// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bus.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_BusList _$$_BusListFromJson(Map<String, dynamic> json) => _$_BusList(
      capturedAt: json['capturedAt'] as String,
      busArrivalList: (json['busArrivalList'] as List<dynamic>)
          .map((e) => Bus.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$$_BusListToJson(_$_BusList instance) =>
    <String, dynamic>{
      'capturedAt': instance.capturedAt,
      'busArrivalList': instance.busArrivalList,
    };

_$_BusInfo _$$_BusInfoFromJson(Map<String, dynamic> json) => _$_BusInfo(
      jungmoonBus:
          BusList.fromJson(json['jungmoonBus'] as Map<String, dynamic>),
      gomsangBus: BusList.fromJson(json['gomsangBus'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$_BusInfoToJson(_$_BusInfo instance) =>
    <String, dynamic>{
      'jungmoonBus': instance.jungmoonBus,
      'gomsangBus': instance.gomsangBus,
    };

_$_Bus _$$_BusFromJson(Map<String, dynamic> json) => _$_Bus(
      locationNo1: json['locationNo1'] as int? ?? 0,
      predictTime1: json['predictTime1'] as int? ?? 0,
      busNo: json['busNo'] as String,
    );

Map<String, dynamic> _$$_BusToJson(_$_Bus instance) => <String, dynamic>{
      'locationNo1': instance.locationNo1,
      'predictTime1': instance.predictTime1,
      'busNo': instance.busNo,
    };
