import 'package:json_annotation/json_annotation.dart';

import '../../../../core/utils/data_mapper.dart';
import '../../domain/models/search_result.dart';
import 'search_board_dto.dart';

part 'search_result_dto.g.dart';

@JsonSerializable()
class SearchResultDTO extends DataMapper<SearchResult> {

  final SearchBoardDTO notices;
  final SearchBoardDTO coalitions;
  final SearchBoardDTO petitions;

  SearchResultDTO({
    required this.notices,
    required this.coalitions,
    required this.petitions,
  });

  factory SearchResultDTO.fromJson(Map<String, dynamic> json) =>
      _$SearchResultDTOFromJson(json);

  Map<String, dynamic> toJson() => _$SearchResultDTOToJson(this);

  @override
  SearchResult mapToModel(){
    return SearchResult(
      notices: notices.mapToModel(),
      coalitions: coalitions.mapToModel(),
      petitions: petitions.mapToModel(),
    );
  }
}
