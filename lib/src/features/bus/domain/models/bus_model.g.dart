// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bus_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$BusModelImpl _$$BusModelImplFromJson(Map<String, dynamic> json) =>
    _$BusModelImpl(
      location: json['locationNo1'] as int? ?? 0,
      predictTime: json['predictTime1'] as int? ?? 0,
      busNo: json['busNo'] as String,
    );

Map<String, dynamic> _$$BusModelImplToJson(_$BusModelImpl instance) =>
    <String, dynamic>{
      'locationNo1': instance.location,
      'predictTime1': instance.predictTime,
      'busNo': instance.busNo,
    };
