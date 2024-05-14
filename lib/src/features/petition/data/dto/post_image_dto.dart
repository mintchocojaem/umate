import 'package:json_annotation/json_annotation.dart';

import '../../domain/models/image.dart';
import 'post_file_dto.dart';

part 'post_image_dto.g.dart';

@JsonSerializable()
class PostImageDTO extends PostFileDTO {
  final String thumbnailUrl;

  PostImageDTO({
    required super.id,
    required super.url,
    required super.originalName,
    required super.mimeType,
    required this.thumbnailUrl,
  });

  factory PostImageDTO.fromJson(Map<String, dynamic> json) =>
      _$PostImageDTOFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$PostImageDTOToJson(this);

  @override
  PostImage mapToModel() {
    // TODO: implement mapToModel
    return PostImage(
      id: id,
      url: url,
      name: originalName,
      mimeType: mimeType,
      thumbnailUrl: thumbnailUrl,
    );
  }
}
