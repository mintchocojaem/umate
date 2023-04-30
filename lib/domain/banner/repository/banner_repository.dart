import 'package:danvery/core/dto/api_response_dto.dart';
import 'package:danvery/domain/banner/provider/banner_provider.dart';

class BannerRepository {
  final BannerProvider bannerProvider;

  static final BannerRepository _singleton =
  BannerRepository._internal(BannerProvider());

  BannerRepository._internal(this.bannerProvider);

  factory BannerRepository() => _singleton;

  Future<ApiResponseDTO> getBannerList() async {
    return await bannerProvider.getBannerList();
  }
}
