class CheckUpdateModel{
  final String minVersion;
  final String latestVersion;

  CheckUpdateModel({
    required this.minVersion,
    required this.latestVersion
  });

  factory CheckUpdateModel.fromJson(Map<String, dynamic> json) {
    return CheckUpdateModel(
      minVersion: json['min_version'],
      latestVersion: json['latest_version'],
    );
  }

}
