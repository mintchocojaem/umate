
import 'package:json_annotation/json_annotation.dart';

import '../../../../core/utils/data_mapper.dart';
import '../../domain/models/petition_board_model.dart';
import 'petition_post_dto.dart';

part 'petition_board_dto.g.dart';

@JsonSerializable()
class PetitionBoardDTO extends DataMapper<PetitionBoardModel>{

  final List<PetitionPostDTO> content;
  final bool hasNext;
  final int totalPages;
  final int totalElements;
  final int page;
  final int size;
  final bool first;
  final bool last;

  PetitionBoardDTO({
    required this.content,
    required this.hasNext,
    required this.totalPages,
    required this.totalElements,
    required this.page,
    required this.size,
    required this.first,
    required this.last,
  });

  factory PetitionBoardDTO.fromJson(Map<String, dynamic> json) => _$PetitionBoardDTOFromJson(json);

  Map<String, dynamic> toJson() => _$PetitionBoardDTOToJson(this);

  @override
  PetitionBoardModel mapToModel() {
    return PetitionBoardModel(
      content: content.map((e) => e.mapToModel()).toList(),
      hasNext: hasNext,
      totalPages: totalPages,
      totalElements: totalElements,
      page: page,
      size: size,
      first: first,
      last: last,
    );
  }

}