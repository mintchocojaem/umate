// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bus_arrival_info_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$BusArrivalInfoModelImpl _$$BusArrivalInfoModelImplFromJson(
        Map<String, dynamic> json) =>
    _$BusArrivalInfoModelImpl(
      entranceBusList: (json['busArrivalEntranceList'] as List<dynamic>)
          .map((e) => BusModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      plazaBusList: (json['busArrivalPlazaList'] as List<dynamic>)
          .map((e) => BusModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$$BusArrivalInfoModelImplToJson(
        _$BusArrivalInfoModelImpl instance) =>
    <String, dynamic>{
      'busArrivalEntranceList':
          instance.entranceBusList.map((e) => e.toJson()).toList(),
      'busArrivalPlazaList':
          instance.plazaBusList.map((e) => e.toJson()).toList(),
    };
