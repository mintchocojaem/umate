import 'package:freezed_annotation/freezed_annotation.dart';

import 'bus_model.dart';

part 'bus_arrival_info_model.freezed.dart';

part 'bus_arrival_info_model.g.dart';

@freezed
class BusArrivalInfoModel with _$BusArrivalInfoModel {
  const factory BusArrivalInfoModel({
    @JsonKey(name: 'busArrivalEntranceList') required List<BusModel> entranceBusList,
    @JsonKey(name: 'busArrivalPlazaList') required List<BusModel> plazaBusList,
  }) = _BusArrivalInfoModel;

  factory BusArrivalInfoModel.fromJson(Map<String, dynamic> json) =>
      _$BusArrivalInfoModelFromJson(json);
}
