// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'bus_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

BusModel _$BusModelFromJson(Map<String, dynamic> json) {
  return _BusModel.fromJson(json);
}

/// @nodoc
mixin _$BusModel {
  @JsonKey(name: 'locationNo1')
  int? get remainingStation => throw _privateConstructorUsedError;
  @JsonKey(name: 'predictTime1')
  int? get predictTime => throw _privateConstructorUsedError;
  String get busNo => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $BusModelCopyWith<BusModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $BusModelCopyWith<$Res> {
  factory $BusModelCopyWith(BusModel value, $Res Function(BusModel) then) =
      _$BusModelCopyWithImpl<$Res, BusModel>;
  @useResult
  $Res call(
      {@JsonKey(name: 'locationNo1') int? remainingStation,
      @JsonKey(name: 'predictTime1') int? predictTime,
      String busNo});
}

/// @nodoc
class _$BusModelCopyWithImpl<$Res, $Val extends BusModel>
    implements $BusModelCopyWith<$Res> {
  _$BusModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? remainingStation = freezed,
    Object? predictTime = freezed,
    Object? busNo = null,
  }) {
    return _then(_value.copyWith(
      remainingStation: freezed == remainingStation
          ? _value.remainingStation
          : remainingStation // ignore: cast_nullable_to_non_nullable
              as int?,
      predictTime: freezed == predictTime
          ? _value.predictTime
          : predictTime // ignore: cast_nullable_to_non_nullable
              as int?,
      busNo: null == busNo
          ? _value.busNo
          : busNo // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$BusModelImplCopyWith<$Res>
    implements $BusModelCopyWith<$Res> {
  factory _$$BusModelImplCopyWith(
          _$BusModelImpl value, $Res Function(_$BusModelImpl) then) =
      __$$BusModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'locationNo1') int? remainingStation,
      @JsonKey(name: 'predictTime1') int? predictTime,
      String busNo});
}

/// @nodoc
class __$$BusModelImplCopyWithImpl<$Res>
    extends _$BusModelCopyWithImpl<$Res, _$BusModelImpl>
    implements _$$BusModelImplCopyWith<$Res> {
  __$$BusModelImplCopyWithImpl(
      _$BusModelImpl _value, $Res Function(_$BusModelImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? remainingStation = freezed,
    Object? predictTime = freezed,
    Object? busNo = null,
  }) {
    return _then(_$BusModelImpl(
      remainingStation: freezed == remainingStation
          ? _value.remainingStation
          : remainingStation // ignore: cast_nullable_to_non_nullable
              as int?,
      predictTime: freezed == predictTime
          ? _value.predictTime
          : predictTime // ignore: cast_nullable_to_non_nullable
              as int?,
      busNo: null == busNo
          ? _value.busNo
          : busNo // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$BusModelImpl implements _BusModel {
  const _$BusModelImpl(
      {@JsonKey(name: 'locationNo1') this.remainingStation,
      @JsonKey(name: 'predictTime1') this.predictTime,
      required this.busNo});

  factory _$BusModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$BusModelImplFromJson(json);

  @override
  @JsonKey(name: 'locationNo1')
  final int? remainingStation;
  @override
  @JsonKey(name: 'predictTime1')
  final int? predictTime;
  @override
  final String busNo;

  @override
  String toString() {
    return 'BusModel(remainingStation: $remainingStation, predictTime: $predictTime, busNo: $busNo)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$BusModelImpl &&
            (identical(other.remainingStation, remainingStation) ||
                other.remainingStation == remainingStation) &&
            (identical(other.predictTime, predictTime) ||
                other.predictTime == predictTime) &&
            (identical(other.busNo, busNo) || other.busNo == busNo));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, remainingStation, predictTime, busNo);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$BusModelImplCopyWith<_$BusModelImpl> get copyWith =>
      __$$BusModelImplCopyWithImpl<_$BusModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$BusModelImplToJson(
      this,
    );
  }
}

abstract class _BusModel implements BusModel {
  const factory _BusModel(
      {@JsonKey(name: 'locationNo1') final int? remainingStation,
      @JsonKey(name: 'predictTime1') final int? predictTime,
      required final String busNo}) = _$BusModelImpl;

  factory _BusModel.fromJson(Map<String, dynamic> json) =
      _$BusModelImpl.fromJson;

  @override
  @JsonKey(name: 'locationNo1')
  int? get remainingStation;
  @override
  @JsonKey(name: 'predictTime1')
  int? get predictTime;
  @override
  String get busNo;
  @override
  @JsonKey(ignore: true)
  _$$BusModelImplCopyWith<_$BusModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
