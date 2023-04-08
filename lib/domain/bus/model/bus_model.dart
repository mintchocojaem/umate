class BusModel {
  String status;
  int? locationNo1;
  int? predictTime1;
  String? plateNo1;
  int? locationNo2;
  int? predictTime2;
  String? plateNo2;
  String busNo;

  BusModel({
    required this.status,
    this.locationNo1,
    this.predictTime1,
    this.plateNo1,
    this.locationNo2,
    this.predictTime2,
    this.plateNo2,
    required this.busNo,
  });

  factory BusModel.fromJson(Map<String, dynamic> json) {
    return BusModel(
      status: json["status"] as String,
      locationNo1: json["locationNo1"] as int?,
      predictTime1: json["predictTime1"] as int?,
      plateNo1: json["plateNo1"] as String?,
      locationNo2: json["locationNo2"] as int?,
      predictTime2: json["predictTime2"] as int?,
      plateNo2: json["plateNo2"] as String?,
      busNo: json["busNo"] as String,
    );
  }

}
