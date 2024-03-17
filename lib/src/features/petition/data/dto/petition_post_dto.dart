import 'package:danvery/src/features/petition/domain/models/petition_status_model.dart';
import 'package:json_annotation/json_annotation.dart';

import '../../../../core/utils/data_mapper.dart';
import '../../domain/models/petition_post_model.dart';

part 'petition_post_dto.g.dart';

@JsonSerializable()
class PetitionPostDTO extends DataMapper<PetitionPostModel> {
  final int id;
  final String title;
  final String author;
  final String body;
  final String? answer;
  final String createdAt;
  //files
  //images
  final String status;
  final String expiresAt;
  final int agreeCount;
  //statistics
  final bool agree;
  final bool mine;
  final bool blinded;

  PetitionPostDTO({
    required this.id,
    required this.title,
    required this.author,
    required this.body,
    required this.answer,
    required this.createdAt,
    required this.status,
    required this.expiresAt,
    required this.agreeCount,
    required this.agree,
    required this.mine,
    required this.blinded,
  });

  factory PetitionPostDTO.fromJson(Map<String, dynamic> json) =>
      _$PetitionPostDTOFromJson(json);

  Map<String, dynamic> toJson() => _$PetitionPostDTOToJson(this);

  @override
  PetitionPostModel mapToModel() {
    return PetitionPostModel(
      id: id,
      title: title,
      author: author,
      body: body,
      answer: answer,
      createdAt: createdAt,
      status: PetitionStatusModel.fromJson(status),
      expiresAt: expiresAt,
      agreeCount: agreeCount,
      agree: agree,
      mine: mine,
      blinded: blinded,
    );
  }
}