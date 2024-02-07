import 'package:freezed_annotation/freezed_annotation.dart';

part 'bus_model.freezed.dart';
part 'bus_model.g.dart';

@freezed
class BusModel with _$BusModel {
  const factory BusModel({
    @JsonKey(name: 'locationNo1') @Default(0) int location,
    @JsonKey(name: 'predictTime1') @Default(0) int predictTime,
    required String busNo,
  }) = _BusModel;

  factory BusModel.fromJson(Map<String, dynamic> json) =>
      _$BusModelFromJson(json);
}
