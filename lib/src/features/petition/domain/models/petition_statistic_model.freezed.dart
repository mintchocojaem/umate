// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'petition_statistic_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

PetitionStatisticModel _$PetitionStatisticModelFromJson(
    Map<String, dynamic> json) {
  return _PetitionStatisticModel.fromJson(json);
}

/// @nodoc
mixin _$PetitionStatisticModel {
  String get department => throw _privateConstructorUsedError;
  int get agreeCount => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $PetitionStatisticModelCopyWith<PetitionStatisticModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PetitionStatisticModelCopyWith<$Res> {
  factory $PetitionStatisticModelCopyWith(PetitionStatisticModel value,
          $Res Function(PetitionStatisticModel) then) =
      _$PetitionStatisticModelCopyWithImpl<$Res, PetitionStatisticModel>;
  @useResult
  $Res call({String department, int agreeCount});
}

/// @nodoc
class _$PetitionStatisticModelCopyWithImpl<$Res,
        $Val extends PetitionStatisticModel>
    implements $PetitionStatisticModelCopyWith<$Res> {
  _$PetitionStatisticModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? department = null,
    Object? agreeCount = null,
  }) {
    return _then(_value.copyWith(
      department: null == department
          ? _value.department
          : department // ignore: cast_nullable_to_non_nullable
              as String,
      agreeCount: null == agreeCount
          ? _value.agreeCount
          : agreeCount // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$PetitionStatisticModelImplCopyWith<$Res>
    implements $PetitionStatisticModelCopyWith<$Res> {
  factory _$$PetitionStatisticModelImplCopyWith(
          _$PetitionStatisticModelImpl value,
          $Res Function(_$PetitionStatisticModelImpl) then) =
      __$$PetitionStatisticModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String department, int agreeCount});
}

/// @nodoc
class __$$PetitionStatisticModelImplCopyWithImpl<$Res>
    extends _$PetitionStatisticModelCopyWithImpl<$Res,
        _$PetitionStatisticModelImpl>
    implements _$$PetitionStatisticModelImplCopyWith<$Res> {
  __$$PetitionStatisticModelImplCopyWithImpl(
      _$PetitionStatisticModelImpl _value,
      $Res Function(_$PetitionStatisticModelImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? department = null,
    Object? agreeCount = null,
  }) {
    return _then(_$PetitionStatisticModelImpl(
      department: null == department
          ? _value.department
          : department // ignore: cast_nullable_to_non_nullable
              as String,
      agreeCount: null == agreeCount
          ? _value.agreeCount
          : agreeCount // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$PetitionStatisticModelImpl implements _PetitionStatisticModel {
  const _$PetitionStatisticModelImpl(
      {required this.department, required this.agreeCount});

  factory _$PetitionStatisticModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$PetitionStatisticModelImplFromJson(json);

  @override
  final String department;
  @override
  final int agreeCount;

  @override
  String toString() {
    return 'PetitionStatisticModel(department: $department, agreeCount: $agreeCount)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PetitionStatisticModelImpl &&
            (identical(other.department, department) ||
                other.department == department) &&
            (identical(other.agreeCount, agreeCount) ||
                other.agreeCount == agreeCount));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, department, agreeCount);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$PetitionStatisticModelImplCopyWith<_$PetitionStatisticModelImpl>
      get copyWith => __$$PetitionStatisticModelImplCopyWithImpl<
          _$PetitionStatisticModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$PetitionStatisticModelImplToJson(
      this,
    );
  }
}

abstract class _PetitionStatisticModel implements PetitionStatisticModel {
  const factory _PetitionStatisticModel(
      {required final String department,
      required final int agreeCount}) = _$PetitionStatisticModelImpl;

  factory _PetitionStatisticModel.fromJson(Map<String, dynamic> json) =
      _$PetitionStatisticModelImpl.fromJson;

  @override
  String get department;
  @override
  int get agreeCount;
  @override
  @JsonKey(ignore: true)
  _$$PetitionStatisticModelImplCopyWith<_$PetitionStatisticModelImpl>
      get copyWith => throw _privateConstructorUsedError;
}
