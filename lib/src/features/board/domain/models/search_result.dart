import 'package:json_annotation/json_annotation.dart';

import 'board.dart';
import 'coalition_post.dart';
import 'notice_post.dart';
import 'petition_post.dart';

part 'search_result.g.dart';

@JsonSerializable()
class SearchResult {
  final Board<NoticePost> notices;
  final Board<CoalitionPost> coalitions;
  final Board<PetitionPost> petitions;

  SearchResult({
    required this.notices,
    required this.coalitions,
    required this.petitions,
  });

  factory SearchResult.fromJson(Map<String, dynamic> json) =>
      _$SearchResultFromJson(json);

  Map<String, dynamic> toJson() => _$SearchResultToJson(this);
}
