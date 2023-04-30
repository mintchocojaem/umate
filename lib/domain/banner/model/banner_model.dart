class BannerModel {
  String? actionUrl;
  String bannerUrl;
  String detailUrl;

  BannerModel({
    this.actionUrl,
    required this.bannerUrl,
    required this.detailUrl,
  });

  factory BannerModel.fromJson(Map<String, dynamic> json) {
    return BannerModel(
      actionUrl: json["actionUrl"] as String?,
      bannerUrl: json["bannerUrl"] as String,
      detailUrl: json["detailUrl"] as String,
    );
  }
}
