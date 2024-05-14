// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'carousel_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CarouselDTO _$CarouselDTOFromJson(Map<String, dynamic> json) => CarouselDTO(
      id: (json['id'] as num).toInt(),
      url: json['url'] as String,
      redirectUrl: json['redirectUrl'] as String,
    );

Map<String, dynamic> _$CarouselDTOToJson(CarouselDTO instance) =>
    <String, dynamic>{
      'id': instance.id,
      'url': instance.url,
      'redirectUrl': instance.redirectUrl,
    };
