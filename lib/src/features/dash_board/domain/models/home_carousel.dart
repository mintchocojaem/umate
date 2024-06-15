import 'package:json_annotation/json_annotation.dart';

import 'carousel_type.dart';

part 'home_carousel.g.dart';

@JsonSerializable()
class HomeCarousel {
  final int id;
  final String url;
  final String redirectUrl;

  CarouselType get bannerType {
    final redirectType = redirectUrl.split("/")[1];
    final redirectId = redirectUrl.split("/")[2];

    return CarouselType(
      type: redirectType,
      id: redirectId,
    );
  }

  HomeCarousel({
    required this.id,
    required this.url,
    required this.redirectUrl,
  });

  factory HomeCarousel.fromJson(Map<String, dynamic> json) =>
      _$HomeCarouselFromJson(json);

  Map<String, dynamic> toJson() => _$HomeCarouselToJson(this);
}
