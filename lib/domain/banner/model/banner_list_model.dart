import 'package:danvery/domain/banner/model/banner_model.dart';

class BannerListModel {
  List<BannerModel> bannerList;
  List<BannerModel> subBannerList;

  BannerListModel({
    required this.bannerList,
    required this.subBannerList,
  });

  factory BannerListModel.fromJson(Map<String, dynamic> json) {
    return BannerListModel(
      bannerList: (json["banner_list"] as List).map((e) => BannerModel.fromJson(e)).toList(),
      subBannerList: (json["sub_banner_list"] as List).map((e) => BannerModel.fromJson(e)).toList(),
    );
  }

  List<dynamic> toJson() {
    return [
      {
        "banner_list": bannerList.map((e) => e.toJson()).toList(),
        "sub_banner_list": subBannerList.map((e) => e.toJson()).toList(),
      }
    ];
  }
}
