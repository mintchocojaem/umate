import 'package:json_annotation/json_annotation.dart';

import '../../../../core/utils/data_mapper.dart';
import '../../domain/models/carousel.dart';

part 'carousel_dto.g.dart';

@JsonSerializable()
class CarouselDTO extends DataMapper<Carousel> {
  final int id;
  final String url;
  final String redirectUrl;

  CarouselDTO({
    required this.id,
    required this.url,
    required this.redirectUrl,
  });

  factory CarouselDTO.fromJson(Map<String, dynamic> json) =>
      _$CarouselDTOFromJson(json);

  Map<String, dynamic> toJson() => _$CarouselDTOToJson(this);

  @override
  Carousel mapToModel() {
    // TODO: implement mapToModel
    return Carousel(
      id: id,
      url: url,
      redirectUrl: redirectUrl,
    );
  }
}
