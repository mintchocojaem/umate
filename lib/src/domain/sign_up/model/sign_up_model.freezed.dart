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
  String get signupToken => throw _privateConstructorUsedError;
  StudentModel get student => throw _privateConstructorUsedError;

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
  $Res call({String signupToken, StudentModel student});

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
    Object? signupToken = null,
    Object? student = null,
  }) {
    return _then(_value.copyWith(
      signupToken: null == signupToken
          ? _value.signupToken
          : signupToken // ignore: cast_nullable_to_non_nullable
              as String,
      student: null == student
          ? _value.student
          : student // ignore: cast_nullable_to_non_nullable
              as StudentModel,
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
  $Res call({String signupToken, StudentModel student});

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
    Object? signupToken = null,
    Object? student = null,
  }) {
    return _then(_$SignUpModelImpl(
      signupToken: null == signupToken
          ? _value.signupToken
          : signupToken // ignore: cast_nullable_to_non_nullable
              as String,
      student: null == student
          ? _value.student
          : student // ignore: cast_nullable_to_non_nullable
              as StudentModel,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$SignUpModelImpl implements _SignUpModel {
  const _$SignUpModelImpl({required this.signupToken, required this.student});

  factory _$SignUpModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$SignUpModelImplFromJson(json);

  @override
  final String signupToken;
  @override
  final StudentModel student;

  @override
  String toString() {
    return 'SignUpModel(signupToken: $signupToken, student: $student)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SignUpModelImpl &&
            (identical(other.signupToken, signupToken) ||
                other.signupToken == signupToken) &&
            (identical(other.student, student) || other.student == student));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, signupToken, student);

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
      {required final String signupToken,
      required final StudentModel student}) = _$SignUpModelImpl;

  factory _SignUpModel.fromJson(Map<String, dynamic> json) =
      _$SignUpModelImpl.fromJson;

  @override
  String get signupToken;
  @override
  StudentModel get student;
  @override
  @JsonKey(ignore: true)
  _$$SignUpModelImplCopyWith<_$SignUpModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
