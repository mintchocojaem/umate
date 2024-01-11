// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'sign_up_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

SignUpModel _$SignUpModelFromJson(Map<String, dynamic> json) {
  return _SignUpModel.fromJson(json);
}

/// @nodoc
mixin _$SignUpModel {
  String get signUpToken => throw _privateConstructorUsedError;
  StudentModel get student => throw _privateConstructorUsedError;
  String? get validPhoneNumber => throw _privateConstructorUsedError;
  String? get validNickname => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $SignUpModelCopyWith<SignUpModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SignUpModelCopyWith<$Res> {
  factory $SignUpModelCopyWith(
          SignUpModel value, $Res Function(SignUpModel) then) =
      _$SignUpModelCopyWithImpl<$Res, SignUpModel>;
  @useResult
  $Res call(
      {String signUpToken,
      StudentModel student,
      String? validPhoneNumber,
      String? validNickname});

  $StudentModelCopyWith<$Res> get student;
}

/// @nodoc
class _$SignUpModelCopyWithImpl<$Res, $Val extends SignUpModel>
    implements $SignUpModelCopyWith<$Res> {
  _$SignUpModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? signUpToken = null,
    Object? student = null,
    Object? validPhoneNumber = freezed,
    Object? validNickname = freezed,
  }) {
    return _then(_value.copyWith(
      signUpToken: null == signUpToken
          ? _value.signUpToken
          : signUpToken // ignore: cast_nullable_to_non_nullable
              as String,
      student: null == student
          ? _value.student
          : student // ignore: cast_nullable_to_non_nullable
              as StudentModel,
      validPhoneNumber: freezed == validPhoneNumber
          ? _value.validPhoneNumber
          : validPhoneNumber // ignore: cast_nullable_to_non_nullable
              as String?,
      validNickname: freezed == validNickname
          ? _value.validNickname
          : validNickname // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $StudentModelCopyWith<$Res> get student {
    return $StudentModelCopyWith<$Res>(_value.student, (value) {
      return _then(_value.copyWith(student: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$SignUpModelImplCopyWith<$Res>
    implements $SignUpModelCopyWith<$Res> {
  factory _$$SignUpModelImplCopyWith(
          _$SignUpModelImpl value, $Res Function(_$SignUpModelImpl) then) =
      __$$SignUpModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String signUpToken,
      StudentModel student,
      String? validPhoneNumber,
      String? validNickname});

  @override
  $StudentModelCopyWith<$Res> get student;
}

/// @nodoc
class __$$SignUpModelImplCopyWithImpl<$Res>
    extends _$SignUpModelCopyWithImpl<$Res, _$SignUpModelImpl>
    implements _$$SignUpModelImplCopyWith<$Res> {
  __$$SignUpModelImplCopyWithImpl(
      _$SignUpModelImpl _value, $Res Function(_$SignUpModelImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? signUpToken = null,
    Object? student = null,
    Object? validPhoneNumber = freezed,
    Object? validNickname = freezed,
  }) {
    return _then(_$SignUpModelImpl(
      signUpToken: null == signUpToken
          ? _value.signUpToken
          : signUpToken // ignore: cast_nullable_to_non_nullable
              as String,
      student: null == student
          ? _value.student
          : student // ignore: cast_nullable_to_non_nullable
              as StudentModel,
      validPhoneNumber: freezed == validPhoneNumber
          ? _value.validPhoneNumber
          : validPhoneNumber // ignore: cast_nullable_to_non_nullable
              as String?,
      validNickname: freezed == validNickname
          ? _value.validNickname
          : validNickname // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$SignUpModelImpl implements _SignUpModel {
  const _$SignUpModelImpl(
      {required this.signUpToken,
      required this.student,
      this.validPhoneNumber,
      this.validNickname});

  factory _$SignUpModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$SignUpModelImplFromJson(json);

  @override
  final String signUpToken;
  @override
  final StudentModel student;
  @override
  final String? validPhoneNumber;
  @override
  final String? validNickname;

  @override
  String toString() {
    return 'SignUpModel(signUpToken: $signUpToken, student: $student, validPhoneNumber: $validPhoneNumber, validNickname: $validNickname)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SignUpModelImpl &&
            (identical(other.signUpToken, signUpToken) ||
                other.signUpToken == signUpToken) &&
            (identical(other.student, student) || other.student == student) &&
            (identical(other.validPhoneNumber, validPhoneNumber) ||
                other.validPhoneNumber == validPhoneNumber) &&
            (identical(other.validNickname, validNickname) ||
                other.validNickname == validNickname));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType, signUpToken, student, validPhoneNumber, validNickname);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$SignUpModelImplCopyWith<_$SignUpModelImpl> get copyWith =>
      __$$SignUpModelImplCopyWithImpl<_$SignUpModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$SignUpModelImplToJson(
      this,
    );
  }
}

abstract class _SignUpModel implements SignUpModel {
  const factory _SignUpModel(
      {required final String signUpToken,
      required final StudentModel student,
      final String? validPhoneNumber,
      final String? validNickname}) = _$SignUpModelImpl;

  factory _SignUpModel.fromJson(Map<String, dynamic> json) =
      _$SignUpModelImpl.fromJson;

  @override
  String get signUpToken;
  @override
  StudentModel get student;
  @override
  String? get validPhoneNumber;
  @override
  String? get validNickname;
  @override
  @JsonKey(ignore: true)
  _$$SignUpModelImplCopyWith<_$SignUpModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
