// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bus.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$BusListImpl _$$BusListImplFromJson(Map<String, dynamic> json) =>
    _$BusListImpl(
      capturedAt: json['capturedAt'] as String,
      busArrivalList: (json['busArrivalList'] as List<dynamic>)
          .map((e) => Bus.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$$BusListImplToJson(_$BusListImpl instance) =>
    <String, dynamic>{
      'capturedAt': instance.capturedAt,
      'busArrivalList': instance.busArrivalList.map((e) => e.toJson()).toList(),
    };

_$BusInfoImpl _$$BusInfoImplFromJson(Map<String, dynamic> json) =>
    _$BusInfoImpl(
      jungmoonBus:
          BusList.fromJson(json['jungmoonBus'] as Map<String, dynamic>),
      gomsangBus: BusList.fromJson(json['gomsangBus'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$BusInfoImplToJson(_$BusInfoImpl instance) =>
    <String, dynamic>{
      'jungmoonBus': instance.jungmoonBus.toJson(),
      'gomsangBus': instance.gomsangBus.toJson(),
    };

_$BusImpl _$$BusImplFromJson(Map<String, dynamic> json) => _$BusImpl(
      locationNo1: json['locationNo1'] as int? ?? 0,
      predictTime1: json['predictTime1'] as int? ?? 0,
      busNo: json['busNo'] as String,
    );

Map<String, dynamic> _$$BusImplToJson(_$BusImpl instance) => <String, dynamic>{
      'locationNo1': instance.locationNo1,
      'predictTime1': instance.predictTime1,
      'busNo': instance.busNo,
    };
