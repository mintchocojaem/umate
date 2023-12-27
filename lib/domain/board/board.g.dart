// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'board.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$BoardImpl _$$BoardImplFromJson(Map<String, dynamic> json) => _$BoardImpl(
      content: (json['content'] as List<dynamic>)
          .map((e) => Petition.fromJson(e as Map<String, dynamic>))
          .toList(),
      hasNext: json['hasNext'] as bool,
      totalPages: json['totalPages'] as int,
      totalElements: json['totalElements'] as int,
      page: json['page'] as int,
      size: json['size'] as int,
      first: json['first'] as bool,
      last: json['last'] as bool,
    );

Map<String, dynamic> _$$BoardImplToJson(_$BoardImpl instance) =>
    <String, dynamic>{
      'content': instance.content.map((e) => e.toJson()).toList(),
      'hasNext': instance.hasNext,
      'totalPages': instance.totalPages,
      'totalElements': instance.totalElements,
      'page': instance.page,
      'size': instance.size,
      'first': instance.first,
      'last': instance.last,
    };
