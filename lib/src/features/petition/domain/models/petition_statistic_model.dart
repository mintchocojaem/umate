import 'package:freezed_annotation/freezed_annotation.dart';

part 'petition_statistic_model.freezed.dart';
part 'petition_statistic_model.g.dart';

@freezed
class PetitionStatisticModel with _$PetitionStatisticModel {
  const factory PetitionStatisticModel({
    required String department,
    required int agreeCount,
  }) = _PetitionStatisticModel;

  factory PetitionStatisticModel.fromJson(Map<String, dynamic> json) =>
      _$PetitionStatisticModelFromJson(json);
}
