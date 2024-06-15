enum BannerType{
  notice,
  coalition,
  petition,
  web,
}

class CarouselType{
  final String type;
  final String id;

  CarouselType({
    required this.type,
    required this.id,
  });
}