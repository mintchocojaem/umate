// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'petition_post_preview_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

PetitionPostPreviewModel _$PetitionPostPreviewModelFromJson(
    Map<String, dynamic> json) {
  return _PetitionPostPreviewModel.fromJson(json);
}

/// @nodoc
mixin _$PetitionPostPreviewModel {
  int get id => throw _privateConstructorUsedError;
  String get title => throw _privateConstructorUsedError;
  String get author => throw _privateConstructorUsedError;
  String get createdAt =>
      throw _privateConstructorUsedError; //required List<PostFile?> files,
//required List<PostImage?> images,
  String get status => throw _privateConstructorUsedError;
  String get expiresAt => throw _privateConstructorUsedError;
  int get agreeCount => throw _privateConstructorUsedError;
  bool get blinded => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $PetitionPostPreviewModelCopyWith<PetitionPostPreviewModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PetitionPostPreviewModelCopyWith<$Res> {
  factory $PetitionPostPreviewModelCopyWith(PetitionPostPreviewModel value,
          $Res Function(PetitionPostPreviewModel) then) =
      _$PetitionPostPreviewModelCopyWithImpl<$Res, PetitionPostPreviewModel>;
  @useResult
  $Res call(
      {int id,
      String title,
      String author,
      String createdAt,
      String status,
      String expiresAt,
      int agreeCount,
      bool blinded});
}

/// @nodoc
class _$PetitionPostPreviewModelCopyWithImpl<$Res,
        $Val extends PetitionPostPreviewModel>
    implements $PetitionPostPreviewModelCopyWith<$Res> {
  _$PetitionPostPreviewModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? author = null,
    Object? createdAt = null,
    Object? status = null,
    Object? expiresAt = null,
    Object? agreeCount = null,
    Object? blinded = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      author: null == author
          ? _value.author
          : author // ignore: cast_nullable_to_non_nullable
              as String,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as String,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String,
      expiresAt: null == expiresAt
          ? _value.expiresAt
          : expiresAt // ignore: cast_nullable_to_non_nullable
              as String,
      agreeCount: null == agreeCount
          ? _value.agreeCount
          : agreeCount // ignore: cast_nullable_to_non_nullable
              as int,
      blinded: null == blinded
          ? _value.blinded
          : blinded // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$PetitionPostPreviewModelImplCopyWith<$Res>
    implements $PetitionPostPreviewModelCopyWith<$Res> {
  factory _$$PetitionPostPreviewModelImplCopyWith(
          _$PetitionPostPreviewModelImpl value,
          $Res Function(_$PetitionPostPreviewModelImpl) then) =
      __$$PetitionPostPreviewModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int id,
      String title,
      String author,
      String createdAt,
      String status,
      String expiresAt,
      int agreeCount,
      bool blinded});
}

/// @nodoc
class __$$PetitionPostPreviewModelImplCopyWithImpl<$Res>
    extends _$PetitionPostPreviewModelCopyWithImpl<$Res,
        _$PetitionPostPreviewModelImpl>
    implements _$$PetitionPostPreviewModelImplCopyWith<$Res> {
  __$$PetitionPostPreviewModelImplCopyWithImpl(
      _$PetitionPostPreviewModelImpl _value,
      $Res Function(_$PetitionPostPreviewModelImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? author = null,
    Object? createdAt = null,
    Object? status = null,
    Object? expiresAt = null,
    Object? agreeCount = null,
    Object? blinded = null,
  }) {
    return _then(_$PetitionPostPreviewModelImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      author: null == author
          ? _value.author
          : author // ignore: cast_nullable_to_non_nullable
              as String,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as String,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String,
      expiresAt: null == expiresAt
          ? _value.expiresAt
          : expiresAt // ignore: cast_nullable_to_non_nullable
              as String,
      agreeCount: null == agreeCount
          ? _value.agreeCount
          : agreeCount // ignore: cast_nullable_to_non_nullable
              as int,
      blinded: null == blinded
          ? _value.blinded
          : blinded // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$PetitionPostPreviewModelImpl implements _PetitionPostPreviewModel {
  const _$PetitionPostPreviewModelImpl(
      {required this.id,
      required this.title,
      required this.author,
      required this.createdAt,
      required this.status,
      required this.expiresAt,
      required this.agreeCount,
      required this.blinded});

  factory _$PetitionPostPreviewModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$PetitionPostPreviewModelImplFromJson(json);

  @override
  final int id;
  @override
  final String title;
  @override
  final String author;
  @override
  final String createdAt;
//required List<PostFile?> files,
//required List<PostImage?> images,
  @override
  final String status;
  @override
  final String expiresAt;
  @override
  final int agreeCount;
  @override
  final bool blinded;

  @override
  String toString() {
    return 'PetitionPostPreviewModel(id: $id, title: $title, author: $author, createdAt: $createdAt, status: $status, expiresAt: $expiresAt, agreeCount: $agreeCount, blinded: $blinded)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PetitionPostPreviewModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.author, author) || other.author == author) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.expiresAt, expiresAt) ||
                other.expiresAt == expiresAt) &&
            (identical(other.agreeCount, agreeCount) ||
                other.agreeCount == agreeCount) &&
            (identical(other.blinded, blinded) || other.blinded == blinded));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, id, title, author, createdAt,
      status, expiresAt, agreeCount, blinded);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$PetitionPostPreviewModelImplCopyWith<_$PetitionPostPreviewModelImpl>
      get copyWith => __$$PetitionPostPreviewModelImplCopyWithImpl<
          _$PetitionPostPreviewModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$PetitionPostPreviewModelImplToJson(
      this,
    );
  }
}

abstract class _PetitionPostPreviewModel implements PetitionPostPreviewModel {
  const factory _PetitionPostPreviewModel(
      {required final int id,
      required final String title,
      required final String author,
      required final String createdAt,
      required final String status,
      required final String expiresAt,
      required final int agreeCount,
      required final bool blinded}) = _$PetitionPostPreviewModelImpl;

  factory _PetitionPostPreviewModel.fromJson(Map<String, dynamic> json) =
      _$PetitionPostPreviewModelImpl.fromJson;

  @override
  int get id;
  @override
  String get title;
  @override
  String get author;
  @override
  String get createdAt;
  @override //required List<PostFile?> files,
//required List<PostImage?> images,
  String get status;
  @override
  String get expiresAt;
  @override
  int get agreeCount;
  @override
  bool get blinded;
  @override
  @JsonKey(ignore: true)
  _$$PetitionPostPreviewModelImplCopyWith<_$PetitionPostPreviewModelImpl>
      get copyWith => throw _privateConstructorUsedError;
}
