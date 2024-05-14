// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home_board_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

HomeBoardDTO _$HomeBoardDTOFromJson(Map<String, dynamic> json) => HomeBoardDTO(
      carousels: (json['carousels'] as List<dynamic>)
          .map((e) => CarouselDTO.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$HomeBoardDTOToJson(HomeBoardDTO instance) =>
    <String, dynamic>{
      'carousels': instance.carousels.map((e) => e.toJson()).toList(),
    };
