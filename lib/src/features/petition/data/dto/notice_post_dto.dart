import 'package:json_annotation/json_annotation.dart';

import '../../domain/models/notice_post.dart';
import 'post_dto.dart';
import 'post_file_dto.dart';
import 'post_image_dto.dart';

part 'notice_post_dto.g.dart';

@JsonSerializable()
class NoticePostDTO extends PostDTO{

  NoticePostDTO({
    required super.id,
    required super.title,
    required super.author,
    required super.body,
    required super.createdAt,
    super.files,
    super.images,
    super.views,
    super.mine,
    super.blinded,
  });

  factory NoticePostDTO.fromJson(Map<String, dynamic> json) =>
      _$NoticePostDTOFromJson(json);

  Map<String, dynamic> toJson() => _$NoticePostDTOToJson(this);

  @override
  NoticePost mapToModel() {
    // TODO: implement mapToModel
    return NoticePost(
      id: id,
      title: title,
      author: author,
      body: body,
      createdAt: createdAt,
      files: files.map((e) => e.mapToModel()).toList(),
      images: images.map((e) => e.mapToModel()).toList(),
      views: views,
      mine: mine,
      blinded: blinded,
    );
  }

}