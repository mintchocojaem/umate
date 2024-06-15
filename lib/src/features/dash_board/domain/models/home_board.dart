
import 'package:json_annotation/json_annotation.dart';

import 'home_carousel.dart';

part 'home_board.g.dart';

@JsonSerializable()
class HomeBoard{

  final List<HomeCarousel> carousels;

  HomeBoard({
    required this.carousels,
  });

  factory HomeBoard.fromJson(Map<String, dynamic> json) => _$HomeBoardFromJson(json);

  Map<String, dynamic> toJson() => _$HomeBoardToJson(this);
}