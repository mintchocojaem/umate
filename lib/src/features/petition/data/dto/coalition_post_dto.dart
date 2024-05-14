import 'package:json_annotation/json_annotation.dart';

import '../../domain/models/coalition_post.dart';
import 'post_dto.dart';
import 'post_file_dto.dart';
import 'post_image_dto.dart';

part 'coalition_post_dto.g.dart';

@JsonSerializable()
class CoalitionPostDTO extends PostDTO {

  CoalitionPostDTO({
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

  factory CoalitionPostDTO.fromJson(Map<String, dynamic> json) =>
      _$CoalitionPostDTOFromJson(json);

  Map<String, dynamic> toJson() => _$CoalitionPostDTOToJson(this);

  @override
  CoalitionPost mapToModel() {
    // TODO: implement mapToModel
    return CoalitionPost(
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
