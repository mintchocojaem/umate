// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home_carousel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

HomeCarousel _$HomeCarouselFromJson(Map<String, dynamic> json) => HomeCarousel(
      id: (json['id'] as num).toInt(),
      url: json['url'] as String,
      redirectUrl: json['redirectUrl'] as String,
    );

Map<String, dynamic> _$HomeCarouselToJson(HomeCarousel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'url': instance.url,
      'redirectUrl': instance.redirectUrl,
    };
