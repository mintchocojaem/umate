// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home_board.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

HomeBoard _$HomeBoardFromJson(Map<String, dynamic> json) => HomeBoard(
      carousels: (json['carousels'] as List<dynamic>)
          .map((e) => HomeCarousel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$HomeBoardToJson(HomeBoard instance) => <String, dynamic>{
      'carousels': instance.carousels.map((e) => e.toJson()).toList(),
    };
