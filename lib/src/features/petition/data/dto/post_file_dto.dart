import 'package:json_annotation/json_annotation.dart';

import '../../../../core/utils/data_mapper.dart';
import '../../domain/models/file.dart';

part 'post_file_dto.g.dart';

@JsonSerializable()
class PostFileDTO extends DataMapper<PostFile> {
  final int id;
  final String url;
  final String originalName;
  final String mimeType;

  PostFileDTO({
    required this.id,
    required this.url,
    required this.originalName,
    required this.mimeType,
  });

  factory PostFileDTO.fromJson(Map<String, dynamic> json) =>
      _$PostFileDTOFromJson(json);

  Map<String, dynamic> toJson() => _$PostFileDTOToJson(this);

  @override
  PostFile mapToModel() {
    // TODO: implement mapToModel
    return PostFile(
      id: id,
      url: url,
      name: originalName,
      mimeType: mimeType,
    );
  }
}
