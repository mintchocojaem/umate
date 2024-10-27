// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dankook_trade_post.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DankookTradePost _$DankookTradePostFromJson(Map<String, dynamic> json) =>
    DankookTradePost(
      id: (json['id'] as num).toInt(),
      title: json['title'] as String,
      author: json['author'] as String,
      body: json['body'] as String,
      createdAt: json['createdAt'] as String,
      files: (json['files'] as List<dynamic>?)
              ?.map((e) => PostFile.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      images: (json['images'] as List<dynamic>?)
              ?.map((e) => PostImage.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      views: (json['views'] as num?)?.toInt() ?? 0,
      mine: json['mine'] as bool? ?? false,
      blinded: json['blinded'] as bool? ?? false,
      price: (json['price'] as num).toInt(),
      tradePlace: json['tradePlace'] as String,
      status: json['status'] as String,
      gender: json['gender'] as String? ?? '알 수 없음',
      major: json['major'] as String? ?? '알 수 없음',
      kakaoOpenChatLink: json['kakaoOpenChatLink'] as String? ?? '',
    );

Map<String, dynamic> _$DankookTradePostToJson(DankookTradePost instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'author': instance.author,
      'body': instance.body,
      'createdAt': instance.createdAt,
      'files': instance.files.map((e) => e.toJson()).toList(),
      'images': instance.images.map((e) => e.toJson()).toList(),
      'views': instance.views,
      'mine': instance.mine,
      'blinded': instance.blinded,
      'price': instance.price,
      'tradePlace': instance.tradePlace,
      'status': instance.status,
      'gender': instance.gender,
      'major': instance.major,
      'kakaoOpenChatLink': instance.kakaoOpenChatLink,
    };
