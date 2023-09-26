// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'board.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_Board _$$_BoardFromJson(Map<String, dynamic> json) => _$_Board(
      content: (json['content'] as List<dynamic>)
          .map((e) => Post.fromJson(e as Map<String, dynamic>))
          .toList(),
      hasNext: json['hasNext'] as bool,
      totalPages: json['totalPages'] as int,
      totalElements: json['totalElements'] as int,
      page: json['page'] as int,
      size: json['size'] as int,
      first: json['first'] as bool,
      last: json['last'] as bool,
    );

Map<String, dynamic> _$$_BoardToJson(_$_Board instance) => <String, dynamic>{
      'content': instance.content,
      'hasNext': instance.hasNext,
      'totalPages': instance.totalPages,
      'totalElements': instance.totalElements,
      'page': instance.page,
      'size': instance.size,
      'first': instance.first,
      'last': instance.last,
    };
