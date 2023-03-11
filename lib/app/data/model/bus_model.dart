class BusModel {
  late String status;
  late int? locationNo1;
  late int? predictTime1;
  late String? plateNo1;
  late int? locationNo2;
  late int? predictTime2;
  late String? plateNo2;
  late String busNo;

  BusModel(status, locationNo1, predictTime1, plateNo1, locationNo2,
      predictTime2, plateNo2, busNo);

  BusModel.fromJson(Map<String, dynamic> json){
    status = json["status"] as String;
    locationNo1 = json["locationNo1"] as int?;
    predictTime1 = json["predictTime1"] as int?;
    plateNo1 = json["plateNo1"] as String?;
    locationNo2 = json["locationNo2"] as int?;
    predictTime2 = json["predictTime2"] as int?;
    plateNo2 = json["plateNo2"] as String?;
    busNo = json["busNo"] as String;
  }
}
