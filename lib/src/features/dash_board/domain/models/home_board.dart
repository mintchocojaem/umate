import 'package:json_annotation/json_annotation.dart';

import '../../../board/domain/models/petition_post.dart';
import '../../../timetable/domain/models/schedule.dart';
import 'home_carousel.dart';

part 'home_board.g.dart';

@JsonSerializable()
class HomeBoard {
  final List<HomeCarousel> carousels;
  final List<Schedule> schedules;
  final List<PetitionPost> petitions;

  HomeBoard({
    required this.carousels,
    this.schedules = const [],
    this.petitions = const [],
  });

  factory HomeBoard.fromJson(Map<String, dynamic> json) =>
      _$HomeBoardFromJson(json);

  Map<String, dynamic> toJson() => _$HomeBoardToJson(this);

  HomeBoard copyWith({
    List<HomeCarousel>? carousels,
    List<Schedule>? schedules,
    List<PetitionPost>? petitions,
  }) {
    return HomeBoard(
      carousels: carousels ?? this.carousels,
      schedules: schedules ?? this.schedules,
      petitions: petitions ?? this.petitions,
    );
  }
}
