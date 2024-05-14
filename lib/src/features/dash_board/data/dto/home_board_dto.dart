import 'package:json_annotation/json_annotation.dart';

import '../../../../core/utils/data_mapper.dart';
import '../../../petition/data/dto/notice_post_dto.dart';
import '../../../petition/data/dto/petition_post_dto.dart';
import '../../domain/models/home_board.dart';
import 'carousel_dto.dart';

part 'home_board_dto.g.dart';

@JsonSerializable()
class HomeBoardDTO extends DataMapper<HomeBoard> {
  final List<CarouselDTO> carousels;
  //final List<NoticePostDTO> recentNotices;
  //final List<PetitionPostDTO> popularPetitions;

  HomeBoardDTO({
    required this.carousels,
    //required this.recentNotices,
    //required this.popularPetitions,
  });

  factory HomeBoardDTO.fromJson(Map<String, dynamic> json) =>
      _$HomeBoardDTOFromJson(json);

  Map<String, dynamic> toJson() => _$HomeBoardDTOToJson(this);

  @override
  HomeBoard mapToModel() {
    return HomeBoard(
      carousels: carousels.map((e) => e.mapToModel()).toList(),
      petitions: [],
      schedules: [],
    );
  }
}
