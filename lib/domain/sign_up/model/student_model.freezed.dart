// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'student_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

StudentModel _$StudentModelFromJson(Map<String, dynamic> json) {
  return _StudentModel.fromJson(json);
}

/// @nodoc
mixin _$StudentModel {
  String get studentName => throw _privateConstructorUsedError;
  String get studentId => throw _privateConstructorUsedError;
  String get major => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $StudentModelCopyWith<StudentModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $StudentModelCopyWith<$Res> {
  factory $StudentModelCopyWith(
          StudentModel value, $Res Function(StudentModel) then) =
      _$StudentModelCopyWithImpl<$Res, StudentModel>;
  @useResult
  $Res call({String studentName, String studentId, String major});
}

/// @nodoc
class _$StudentModelCopyWithImpl<$Res, $Val extends StudentModel>
    implements $StudentModelCopyWith<$Res> {
  _$StudentModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? studentName = null,
    Object? studentId = null,
    Object? major = null,
  }) {
    return _then(_value.copyWith(
      studentName: null == studentName
          ? _value.studentName
          : studentName // ignore: cast_nullable_to_non_nullable
              as String,
      studentId: null == studentId
          ? _value.studentId
          : studentId // ignore: cast_nullable_to_non_nullable
              as String,
      major: null == major
          ? _value.major
          : major // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$StudentModelImplCopyWith<$Res>
    implements $StudentModelCopyWith<$Res> {
  factory _$$StudentModelImplCopyWith(
          _$StudentModelImpl value, $Res Function(_$StudentModelImpl) then) =
      __$$StudentModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String studentName, String studentId, String major});
}

/// @nodoc
class __$$StudentModelImplCopyWithImpl<$Res>
    extends _$StudentModelCopyWithImpl<$Res, _$StudentModelImpl>
    implements _$$StudentModelImplCopyWith<$Res> {
  __$$StudentModelImplCopyWithImpl(
      _$StudentModelImpl _value, $Res Function(_$StudentModelImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? studentName = null,
    Object? studentId = null,
    Object? major = null,
  }) {
    return _then(_$StudentModelImpl(
      studentName: null == studentName
          ? _value.studentName
          : studentName // ignore: cast_nullable_to_non_nullable
              as String,
      studentId: null == studentId
          ? _value.studentId
          : studentId // ignore: cast_nullable_to_non_nullable
              as String,
      major: null == major
          ? _value.major
          : major // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$StudentModelImpl implements _StudentModel {
  const _$StudentModelImpl(
      {required this.studentName,
      required this.studentId,
      required this.major});

  factory _$StudentModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$StudentModelImplFromJson(json);

  @override
  final String studentName;
  @override
  final String studentId;
  @override
  final String major;

  @override
  String toString() {
    return 'StudentModel(studentName: $studentName, studentId: $studentId, major: $major)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$StudentModelImpl &&
            (identical(other.studentName, studentName) ||
                other.studentName == studentName) &&
            (identical(other.studentId, studentId) ||
                other.studentId == studentId) &&
            (identical(other.major, major) || other.major == major));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, studentName, studentId, major);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$StudentModelImplCopyWith<_$StudentModelImpl> get copyWith =>
      __$$StudentModelImplCopyWithImpl<_$StudentModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$StudentModelImplToJson(
      this,
    );
  }
}

abstract class _StudentModel implements StudentModel {
  const factory _StudentModel(
      {required final String studentName,
      required final String studentId,
      required final String major}) = _$StudentModelImpl;

  factory _StudentModel.fromJson(Map<String, dynamic> json) =
      _$StudentModelImpl.fromJson;

  @override
  String get studentName;
  @override
  String get studentId;
  @override
  String get major;
  @override
  @JsonKey(ignore: true)
  _$$StudentModelImplCopyWith<_$StudentModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
