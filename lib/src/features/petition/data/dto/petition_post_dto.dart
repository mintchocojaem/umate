import 'package:json_annotation/json_annotation.dart';

import '../../domain/models/petition_post.dart';
import '../../domain/models/petition_status.dart';
import 'post_dto.dart';
import 'post_file_dto.dart';
import 'post_image_dto.dart';

part 'petition_post_dto.g.dart';

@JsonSerializable()
class PetitionPostDTO extends PostDTO{

  final String? answer;
  //files
  //images
  final String status;
  final String expiresAt;
  final int agreeCount;
  //statistics
  final bool agree;

  PetitionPostDTO({
    required super.id,
    required super.title,
    required super.author,
    required super.body,
    required super.createdAt,
    super.files,
    super.images,
    required super.views,
    required super.mine,
    required super.blinded,
    this.answer,
    required this.status,
    required this.expiresAt,
    this.agreeCount = 0,
    this.agree = false,
  });


  factory PetitionPostDTO.fromJson(Map<String, dynamic> json) =>
      _$PetitionPostDTOFromJson(json);

  Map<String, dynamic> toJson() => _$PetitionPostDTOToJson(this);

  @override
  PetitionPost mapToModel() {
    return PetitionPost(
      id: id,
      title: title,
      author: author,
      body: body,
      views: views,
      mine: mine,
      blinded: blinded,
      answer: answer,
      createdAt: createdAt,
      files: files.map((e) => e.mapToModel()).toList(),
      images: images.map((e) => e.mapToModel()).toList(),
      status: PetitionStatus.fromValue(status),
      expiresAt: expiresAt,
      agreeCount: agreeCount,
      agree: agree,
    );
  }
}
