class CheckUpdateModel{
  final String minVersionName;
  final int minVersionCode;
  final String latestVersionName;
  final int latestVersionCode;

  CheckUpdateModel({
    required this.minVersionName,
    required this.minVersionCode,
    required this.latestVersionName,
    required this.latestVersionCode,
  });

  factory CheckUpdateModel.fromJson(Map<String, dynamic> json) {
    return CheckUpdateModel(
      minVersionName: json['min_version']["versionName"],
      minVersionCode: json['min_version']["versionCode"],
      latestVersionName: json['latest_version']["versionName"],
      latestVersionCode: json['latest_version']["versionCode"],
    );
  }

}
