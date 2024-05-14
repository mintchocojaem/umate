
import 'package:json_annotation/json_annotation.dart';

import '../../domain/models/search_post.dart';
import 'post_dto.dart';
import 'post_file_dto.dart';
import 'post_image_dto.dart';

part 'search_post_dto.g.dart';

@JsonSerializable()
class SearchPostDTO extends PostDTO {

  SearchPostDTO({
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

  factory SearchPostDTO.fromJson(Map<String, dynamic> json) =>
      _$SearchPostDTOFromJson(json);

  Map<String, dynamic> toJson() => _$SearchPostDTOToJson(this);

  @override
  SearchPost mapToModel() {
    // TODO: implement mapToModel
    return SearchPost(
      id: id,
      title: title,
      body: body,
      createdAt: createdAt,
      files: files.map((e) => e.mapToModel()).toList(),
      images: images.map((e) => e.mapToModel()).toList(),
      author: author,
      views: views,
      mine: mine,
      blinded: blinded,
    );
  }
}
