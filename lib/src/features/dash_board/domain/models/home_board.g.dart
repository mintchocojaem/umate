// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home_board.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

HomeBoard _$HomeBoardFromJson(Map<String, dynamic> json) => HomeBoard(
      carousels: (json['carousels'] as List<dynamic>)
          .map((e) => HomeCarousel.fromJson(e as Map<String, dynamic>))
          .toList(),
      schedules: (json['schedules'] as List<dynamic>?)
              ?.map((e) => Schedule.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      petitions: (json['petitions'] as List<dynamic>?)
              ?.map((e) => PetitionPost.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
    );

Map<String, dynamic> _$HomeBoardToJson(HomeBoard instance) => <String, dynamic>{
      'carousels': instance.carousels.map((e) => e.toJson()).toList(),
      'schedules': instance.schedules.map((e) => e.toJson()).toList(),
      'petitions': instance.petitions.map((e) => e.toJson()).toList(),
    };
